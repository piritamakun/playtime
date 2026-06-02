<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Sync Chat - Custom ID Update</title>
    <script src="https://unpkg.com/peerjs@1.5.2/dist/peerjs.min.js"></script>
    <style>
        /* 今までのUIデザイン・配置を完全に維持 */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #313338; color: #dbdee1; height: 100vh; display: flex; overflow: hidden; }
        #sidebar { width: 150px; background: #2b2d31; display: flex; flex-direction: column; align-items: center; padding: 15px 10px; gap: 8px; overflow-y: auto; z-index: 100; border-right: 1px solid #1e1f22; }
        .history-item { width: 100%; padding: 12px 10px; background: #1e1f22; border-radius: 8px; color: #949ba4; text-align: left; font-size: 13px; cursor: pointer; position: relative; border: none; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; transition: 0.2s; }
        .history-item:hover { background: #3f4147; color: white; }
        .history-item.active { background: #85E249; color: #111; font-weight: bold; }
        .status-dot { position: absolute; top: 6px; right: 6px; width: 8px; height: 8px; border-radius: 50%; background: #5c5e66; border: 1px solid #2b2d31; }
        .status-online { background: #23a559; box-shadow: 0 0 5px #23a559; border: none; }
        #main-chat { flex: 1; display: flex; flex-direction: column; width: 100%; background: #313338; }
        #setup-area { background: #1e1f22; color: #dbdee1; padding: 12px 15px; font-size: 13px; border-bottom: 1px solid #2b2d31; }
        .id-display { font-weight: bold; color: #85E249; font-size: 18px; letter-spacing: 1px; cursor: pointer; } /* ★追加: cursor:pointer */
        input[type="text"] { background: #1e1f22; color: white; border: 1px solid #3f4147; outline: none; padding: 6px 10px; border-radius: 6px; }
        header { background: #2b2d31; color: white; padding: 12px 20px; display: flex; justify-content: space-between; align-items: center; min-height: 50px; font-weight: bold; border-bottom: 1px solid #1e1f22; }
        #chat-container { flex: 1; overflow-y: auto; padding: 20px; display: flex; flex-direction: column; gap: 15px; }
        .msg-wrapper { display: flex; flex-direction: column; max-width: 75%; }
        .sent-wrapper { align-self: flex-end; align-items: flex-end; }
        .received-wrapper { align-self: flex-start; align-items: flex-start; }
        .msg { padding: 12px 16px; border-radius: 18px; font-size: 15px; word-wrap: break-word; line-height: 1.5; }
        .sent { background-color: #85E249; color: #111; border-bottom-right-radius: 4px; }
        .received { background-color: #2b2d31; color: #dbdee1; border-bottom-left-radius: 4px; }
        footer { background: #2b2d31; padding: 15px 20px; display: flex; gap: 12px; align-items: center; }
        #message-input { flex: 1; background: #383a40; border: none; padding: 14px 20px; border-radius: 25px; outline: none; font-size: 15px; color: white; }
        #message-input:disabled { background-color: #1e1f22; cursor: not-allowed; opacity: 0.7; }
        #send-btn { background: #85E249; color: #111; border: none; padding: 10px 20px; border-radius: 20px; font-weight: bold; cursor: pointer; }
        #send-btn:disabled { opacity: 0.5; cursor: default; }
        @keyframes pulse { 0% { transform: scale(1); } 50% { transform: scale(1.15); } 100% { transform: scale(1); } }
        .calling { color: #ff4757 !important; animation: pulse 1.2s infinite; }
        #visualizer-canvas { width: 60px; height: 20px; vertical-align: middle; margin-left: 10px; display: none; }
        #incoming-call-modal { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); display: none; justify-content: center; align-items: center; z-index: 200; backdrop-filter: blur(3px); }
        .modal-content { background: #2b2d31; padding: 30px 40px; border-radius: 12px; text-align: center; color: white; border: 1px solid #3f4147; }
        .modal-buttons { display: flex; gap: 15px; margin-top: 25px; justify-content: center; }
        .modal-btn { padding: 12px 30px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; }
        .btn-answer { background: #23a559; color: white; }
        .btn-decline { background: #da373c; color: white; }
        #toast { position: fixed; top: 20px; left: 50%; transform: translateX(-50%) translateY(-20px); background: #85E249; color: #111; padding: 10px 25px; border-radius: 30px; font-weight: bold; opacity: 0; transition: 0.4s; pointer-events: none; z-index: 1000; }
        .toast-show { opacity: 1 !important; transform: translateX(-50%) translateY(0) !important; }
    </style>
</head>
<body>
<div id="sidebar"></div>
<div id="main-chat">
    <div id="setup-area">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px;">
            <div>
                ID: <span id="my-id-display" class="id-display" title="クリックしてIDを変更">----</span>
                <canvas id="visualizer-canvas"></canvas>
            </div>
            <input type="text" id="my-nickname" placeholder="自分の名前">
        </div>
        <div style="display:flex; gap:8px;">
            <input type="text" id="peer-num" placeholder="相手のID" style="flex:1;">
            <button id="connect-btn" style="background:#85E249; color:#111; border:none; padding:0 20px; border-radius:6px; font-weight:bold; cursor:pointer;">接続</button>
        </div>
    </div>
    <header>
        <span id="chat-title">相手を選択してください</span>
        <div style="display: flex; gap: 15px; align-items: center;">
            <button id="call-btn" style="background:none; border:none; color:white; font-size:22px; display:none; cursor:pointer;">📞</button>
            <button id="clear-history" style="background:none; border:none; color:#da373c; font-size:20px; display:none; cursor:pointer;">🗑️</button>
        </div>
    </header>
    <div id="chat-container"></div>
    <footer>
        <input type="text" id="message-input" placeholder="相手を選択してください" disabled>
        <button id="send-btn" disabled>送信</button>
    </footer>
</div>

<div id="incoming-call-modal">
    <div class="modal-content">
        <h3 style="margin-bottom:10px; font-size:22px; color:#85E249;">📞 着信中</h3>
        <p><span id="caller-name-display" style="font-weight:bold; font-size:18px;">相手</span> からの通話</p>
        <div class="modal-buttons">
            <button class="modal-btn btn-decline" id="decline-btn">拒否</button>
            <button class="modal-btn btn-answer" id="answer-btn">応答</button>
        </div>
    </div>
</div>
<div id="toast">通知メッセージ</div>
<audio id="remote-audio" autoplay playsinline style="display:none;"></audio>

<script>
    const VER = "v32"; // カスタムID機能追加版
    const PREFIX = "p2p_stable_" + VER + "_";
    
    // 安定化設定を維持
    const peerConfig = {
        config: {
            'iceServers': [
                { 'urls': 'stun:stun.l.google.com:19302' },
                { 'urls': 'stun:stun1.l.google.com:19302' },
                { 'urls': 'stun:stun2.l.google.com:19302' }
            ],
            'iceCandidatePoolSize': 10
        },
        debug: 1
    };

    // ★ 変更点：初回にIDを決められるようにする
    let myNumber = localStorage.getItem('chat_id_'+VER);
    if (!myNumber) {
        myNumber = prompt("希望する自分のIDを入力してください（例: taro123）\n※空白の場合はランダムになります") || Math.floor(1000 + Math.random() * 9000).toString();
        localStorage.setItem('chat_id_'+VER, myNumber);
    }

    let myNickname = localStorage.getItem('chat_nick_'+VER) || "名無し";
    const nickInput = document.getElementById('my-nickname');
    nickInput.value = myNickname;
    nickInput.oninput = (e) => {
        myNickname = e.target.value || "名無し";
        localStorage.setItem('chat_nick_'+VER, myNickname);
    };

    const peer = new Peer(PREFIX + myNumber, peerConfig);
    
    let connections = {};
    let activePeer = null;
    let isConnecting = false;
    let localStream = null;
    let currentCall = null;
    let pendingCall = null;

    const callBtn = document.getElementById('call-btn');
    const input = document.getElementById('message-input');
    const sendBtn = document.getElementById('send-btn');
    const canvas = document.getElementById('visualizer-canvas');
    const ctx = canvas.getContext('2d');

    function showToast(message) {
        const toast = document.getElementById('toast');
        toast.textContent = message;
        toast.classList.add('toast-show');
        setTimeout(() => toast.classList.remove('toast-show'), 3000);
    }

    peer.on('error', (err) => {
        // ★ 変更点：IDが他の人に使われていた場合のエラー処理
        if (err.type === 'unavailable-id') {
            showToast("⚠️ そのIDは他の人が使用中で、もう使えません");
            localStorage.removeItem('chat_id_'+VER); // 無効なIDを消す
            setTimeout(() => {
                let newId = prompt("⚠️ そのIDは他の人が使用中です。\n別のIDを入力してください:");
                if (newId) {
                    localStorage.setItem('chat_id_'+VER, newId);
                }
                location.reload(); // 画面を更新して新しいIDで入り直す
            }, 1000);
        } else if (err.type === 'peer-unavailable') {
            showToast("⚠️ 相手が見つかりません");
            isConnecting = false;
            updateInputStatus();
        } else if (err.type === 'disconnected') {
            peer.reconnect();
        }
    });

    peer.on('open', () => {
        document.getElementById('my-id-display').textContent = myNumber;
        renderHistory();
    });

    // ★ 変更点：自分のID（緑色の文字）をクリックしてIDを変更できるようにする
    document.getElementById('my-id-display').onclick = () => {
        let newId = prompt("新しいIDを入力してください：", myNumber);
        if (newId && newId !== myNumber) {
            localStorage.setItem('chat_id_'+VER, newId);
            location.reload();
        }
    };

    // 相手から接続されたときの処理（入室通知フラグを立てる）
    peer.on('connection', (conn) => {
        const num = conn.peer.replace(PREFIX, "");
        setupConn(conn, num, true); // true = 相手からの接続
    });

    peer.on('call', (call) => {
        pendingCall = call;
        const callerId = call.peer.replace(PREFIX, "");
        const friends = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        document.getElementById('caller-name-display').textContent = friends[callerId] || callerId;
        document.getElementById('incoming-call-modal').style.display = 'flex';
    });

    document.getElementById('answer-btn').onclick = () => {
        document.getElementById('incoming-call-modal').style.display = 'none';
        if (!pendingCall) return;
        navigator.mediaDevices.getUserMedia({ video: false, audio: { echoCancellation: true, noiseSuppression: true } }).then((stream) => {
            localStream = stream;
            pendingCall.answer(stream);
            startVisualizer(stream);
            setupCallUI(pendingCall);
            pendingCall = null;
        });
    };

    document.getElementById('decline-btn').onclick = () => {
        document.getElementById('incoming-call-modal').style.display = 'none';
        if (pendingCall) { pendingCall.close(); pendingCall = null; }
    };

    document.getElementById('connect-btn').onclick = () => {
        const target = document.getElementById('peer-num').value.trim();
        if (target !== "" && target !== myNumber) {
            isConnecting = true;
            addFriend(target, null); 
            selectChat(target);      
            tryConnect(target);      
        }
    };

    function tryConnect(num) {
        if (connections[num] && connections[num].open) {
            isConnecting = false;
            return;
        }
        const conn = peer.connect(PREFIX + num, { reliable: true });
        // こちらから接続する場合は通知フラグを立てない
        setupConn(conn, num, false);
    }

    // 接続のセットアップ（入室通知のロジック）
    function setupConn(conn, num, isIncoming = false) {
        conn.on('open', () => {
            isConnecting = false;
            connections[num] = conn;

            if (isIncoming) {
                let friends = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
                let name = friends[num] || num;
                showToast(`🟢 ${name} が入りました`);
            }

            addFriend(num, null); 
            renderHistory();
            if(activePeer === num) updateInputStatus();
        });
        conn.on('data', (data) => {
            if (data && data.content) {
                addFriend(num, data.senderName);
                saveMsg(num, data, 'received');
                if (activePeer === num) renderChat();
                renderHistory();
            }
        });
        conn.on('close', () => { 
            delete connections[num]; 
            updateInputStatus();
            renderHistory(); 
        });
    }

    function selectChat(num) {
        let friends = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        if (!friends[num] && num !== activePeer) {
            resetToDefault();
            return;
        }
        activePeer = num;
        updateInputStatus();
        document.getElementById('chat-title').textContent = friends[num] || num;
        document.getElementById('clear-history').style.display = 'block';
        callBtn.style.display = 'block';
        renderChat();
        renderHistory(); 
    }

    function resetToDefault() {
        activePeer = null;
        document.getElementById('chat-title').textContent = "相手を選択してください";
        document.getElementById('chat-container').innerHTML = "";
        document.getElementById('clear-history').style.display = 'none';
        callBtn.style.display = 'none';
        input.disabled = true;
        renderHistory();
    }

    function updateInputStatus() {
        if (!activePeer) return;
        const isConnected = connections[activePeer] && connections[activePeer].open;
        if (isConnected) {
            input.disabled = false;
            input.placeholder = "メッセージを入力...";
            sendBtn.disabled = false;
            sendBtn.style.opacity = "1";
        } else {
            input.disabled = true;
            input.placeholder = isConnecting ? "接続中..." : "オフライン";
            sendBtn.disabled = true;
            sendBtn.style.opacity = "0.5";
            if (currentCall) endCall(); 
        }
    }

    callBtn.onclick = () => {
        if (!activePeer) return;
        if (currentCall) { endCall(); return; }
        navigator.mediaDevices.getUserMedia({ video: false, audio: { echoCancellation: true, noiseSuppression: true } }).then((stream) => {
            localStream = stream;
            const call = peer.call(PREFIX + activePeer, stream);
            startVisualizer(stream);
            setupCallUI(call);
        }).catch(() => showToast("マイクが使えません"));
    };

    function setupCallUI(call) {
        currentCall = call;
        callBtn.textContent = "🔴";
        callBtn.classList.add('calling');
        call.on('stream', (remoteStream) => { 
            const audioEl = document.getElementById('remote-audio');
            audioEl.srcObject = remoteStream;
            audioEl.play().catch(() => {});
            showToast("📞 通話開始");
        });
        call.on('close', () => { endCall(); });
        call.on('error', () => { endCall(); });
    }

    function endCall() {
        if (currentCall) { currentCall.close(); currentCall = null; }
        if (localStream) { localStream.getTracks().forEach(track => track.stop()); localStream = null; }
        stopVisualizer();
        callBtn.textContent = "📞";
        callBtn.classList.remove('calling');
    }

    function startVisualizer(stream) {
        audioContext = new (window.AudioContext || window.webkitAudioContext)();
        analyser = audioContext.createAnalyser();
        const source = audioContext.createMediaStreamSource(stream);
        source.connect(analyser);
        analyser.fftSize = 32;
        const dataArray = new Uint8Array(analyser.frequencyBinCount);
        canvas.style.display = 'inline-block';
        function draw() {
            animationId = requestAnimationFrame(draw);
            analyser.getByteFrequencyData(dataArray);
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            for (let i = 0; i < dataArray.length; i++) {
                ctx.fillStyle = '#85E249';
                ctx.fillRect(i * 4, canvas.height - dataArray[i]/4, 3, dataArray[i]/4);
            }
        }
        draw();
    }

    function stopVisualizer() {
        if (animationId) cancelAnimationFrame(animationId);
        if (audioContext) audioContext.close();
        canvas.style.display = 'none';
    }

    function executeSend() {
        const text = input.value.trim();
        if (!text || !activePeer) return;
        const conn = connections[activePeer];
        if (conn && conn.open) {
            const msgObj = { type: 'text', content: text, senderName: myNickname, time: new Date().toLocaleTimeString() };
            conn.send(msgObj);
            saveMsg(activePeer, msgObj, 'sent');
            input.value = "";
            renderChat();
        }
    }

    function addFriend(num, name) {
        let friends = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        if (name) friends[num] = name;
        else if (!friends[num]) friends[num] = num;
        localStorage.setItem('friends_'+VER, JSON.stringify(friends));
    }

    function renderHistory() {
        let friends = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        const sb = document.getElementById('sidebar');
        sb.innerHTML = '<div style="color:#949ba4; font-size:11px; margin-bottom:10px; font-weight:bold;">履歴</div>';
        Object.keys(friends).forEach(num => {
            const btn = document.createElement('button');
            btn.className = `history-item ${activePeer === num ? 'active' : ''}`;
            const online = connections[num] && connections[num].open;
            btn.innerHTML = `<div class="status-dot ${online ? 'status-online' : ''}"></div>${friends[num] || num}`;
            btn.onclick = () => selectChat(num);
            sb.appendChild(btn);
        });
    }

    function saveMsg(num, msg, type) {
        let log = JSON.parse(localStorage.getItem('log_'+VER+'_'+num) || "[]");
        log.push({ ...msg, chatType: type });
        localStorage.setItem('log_'+VER+'_'+num, JSON.stringify(log));
    }

    function renderChat() {
        const container = document.getElementById('chat-container');
        container.innerHTML = "";
        if (!activePeer) return;
        let log = JSON.parse(localStorage.getItem('log_'+VER+'_'+activePeer) || "[]");
        log.forEach(m => {
            const wrap = document.createElement('div');
            wrap.className = `msg-wrapper ${m.chatType === 'received' ? 'received-wrapper' : 'sent-wrapper'}`;
            const c = document.createElement('div');
            c.className = `msg ${m.chatType === 'received' ? 'received' : 'sent'}`;
            c.textContent = m.content;
            wrap.appendChild(c);
            container.appendChild(wrap);
        });
        container.scrollTop = container.scrollHeight;
    }

    sendBtn.onclick = executeSend;
    input.onkeypress = (e) => { if(e.key === 'Enter') executeSend(); };
    setInterval(() => { if(activePeer) updateInputStatus(); }, 2000);

    document.getElementById('clear-history').onclick = () => {
        if (confirm("履歴を削除しますか？")) {
            localStorage.removeItem('log_'+VER+'_'+activePeer);
            let f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
            delete f[activePeer];
            localStorage.setItem('friends_'+VER, JSON.stringify(f));
            resetToDefault();
        }
    };
</script>
</body>
</html>
