<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Sync Chat - Absolute Voice Sync v70</title>
    <script src="https://unpkg.com/peerjs@1.5.2/dist/peerjs.min.js"></script>
    <style>
        /* デザイン完全維持 ＆ 新機能スタイル追加 */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #313338; color: #dbdee1; height: 100vh; display: flex; overflow: hidden; }
        
        /* サイドバーをフレンド欄として拡張 */
        #sidebar { width: 180px; background: #2b2d31; display: flex; flex-direction: column; align-items: center; padding: 15px 10px; gap: 8px; overflow-y: auto; z-index: 100; border-right: 1px solid #1e1f22; }
        .sidebar-section-title { color: #949ba4; font-size: 11px; margin-top: 5px; margin-bottom: 2px; font-weight: bold; width: 100%; text-align: left; }
        
        /* フレンド追加を見やすく改善 */
        .friend-add-box { width: 100%; display: flex; flex-direction: column; gap: 8px; margin-bottom: 10px; padding: 10px; background: #1e1f22; border: 1px solid #3f4147; border-radius: 8px; transition: 0.2s; }
        .friend-add-box:focus-within { border-color: var(--theme-color, #85E249); box-shadow: 0 0 5px rgba(0,0,0,0.5); }
        .friend-add-box input { width: 100%; background: #2b2d31; color: white; border: 1px solid #3f4147; padding: 6px 8px; border-radius: 4px; font-size: 12px; outline: none; }
        .friend-add-box button { width: 100%; background: var(--theme-color, #85E249); color: #111; border: none; padding: 6px; border-radius: 4px; font-weight: bold; cursor: pointer; font-size: 12px; transition: 0.2s; }
        .friend-add-box button:hover { opacity: 0.8; }
        
        .history-item { width: 100%; padding: 12px 10px; background: #1e1f22; border-radius: 8px; color: #949ba4; text-align: left; font-size: 13px; cursor: pointer; position: relative; border: none; display: flex; align-items: center; justify-content: space-between; transition: 0.2s; }
        .history-item:hover { background: #3f4147; color: white; }
        .history-item.active { background: var(--theme-color, #85E249); color: #111; font-weight: bold; }
        .fav-star { color: #5c5e66; cursor: pointer; font-size: 16px; transition: 0.2s; }
        .fav-star.is-fav { color: #f1c40f !important; }
        .status-dot { width: 8px; height: 8px; border-radius: 50%; background: #5c5e66; margin-right: 5px; flex-shrink: 0; }
        .status-online { background: #23a559; box-shadow: 0 0 5px #23a559; }
        .friend-icon-span { margin-right: 5px; font-size: 14px; width: 18px; height: 18px; display: inline-flex; align-items: center; justify-content: center; }

        #main-chat { flex: 1; display: flex; flex-direction: column; width: 100%; background: #313338; position: relative; }
        #setup-area { background: #1e1f22; color: #dbdee1; padding: 12px 15px; font-size: 13px; border-bottom: 1px solid #2b2d31; display: flex; justify-content: space-between; align-items: center; }
        .id-display { font-weight: bold; color: var(--theme-color, #85E249); font-size: 18px; letter-spacing: 1px; cursor: pointer; text-decoration: underline dotted; }
        input[type="text"] { background: #1e1f22; color: white; border: 1px solid #3f4147; outline: none; padding: 6px 10px; border-radius: 6px; }
        
        header { background: #2b2d31; color: white; padding: 12px 20px; display: flex; justify-content: space-between; align-items: center; min-height: 50px; font-weight: bold; border-bottom: 1px solid #1e1f22; }
        
        /* 拡大表示用エリア */
        #large-video-view { width: 100%; background: #111; display: none; position: relative; border-bottom: 2px solid var(--theme-color, #85E249); text-align: center; }
        #large-video-element { max-width: 100%; max-height: 50vh; object-fit: contain; }
        .large-video-label { position: absolute; bottom: 10px; left: 10px; background: rgba(0,0,0,0.6); padding: 4px 8px; border-radius: 4px; font-size: 12px; color: var(--theme-color, #85E249); }

        /* 一人一人のビデオ枠用グリッドコンテナ */
        #video-grid-container { width: 100%; display: none; background: #1e1f22; padding: 10px; border-bottom: 1px solid #2b2d31; }
        #video-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(140px, 1fr)); gap: 10px; max-height: 30vh; overflow-y: auto; }
        .video-card { background: #2b2d31; border: 2px solid #3f4147; border-radius: 8px; overflow: hidden; position: relative; aspect-ratio: 4/3; display: flex; flex-direction: column; justify-content: center; align-items: center; cursor: pointer; transition: 0.2s; }
        .video-card:hover { border-color: var(--theme-color, #85E249); }
        .video-card.selected-large { border-color: #f1c40f; box-shadow: 0 0 8px #f1c40f; }
        .video-card video { width: 100%; height: 100%; object-fit: cover; background: #000; }
        .video-card-avatar { width: 48px; height: 48px; font-size: 32px; display: flex; align-items: center; justify-content: center; margin-bottom: 5px; }
        .video-card-info { position: absolute; bottom: 0; left: 0; width: 100%; background: rgba(0,0,0,0.6); padding: 3px 6px; font-size: 11px; display: flex; justify-content: space-between; align-items: center; white-space: nowrap; overflow: hidden; }
        .video-card-name { overflow: hidden; text-overflow: ellipsis; display: flex; align-items: center; gap: 4px; }
        .video-card-name-icon { width: 14px; height: 14px; display: inline-flex; align-items: center; justify-content: center; }

        #screen-share-container { width: 100%; background: #000; display: none; position: relative; max-height: 60vh; }
        #screen-video { width: 100%; height: 100%; max-height: 60vh; object-fit: contain; background: #000; }
        
        #chat-container { flex: 1; overflow-y: auto; padding: 20px; display: flex; flex-direction: column; gap: 15px; }
        .msg-wrapper { display: flex; flex-direction: column; max-width: 75%; }
        .sent-wrapper { align-self: flex-end; align-items: flex-end; }
        .received-wrapper { align-self: flex-start; align-items: flex-start; }
        .msg { padding: 12px 16px; border-radius: 18px; font-size: 15px; word-wrap: break-word; line-height: 1.5; }
        .sent { background-color: var(--theme-color, #85E249); color: #111; border-bottom-right-radius: 4px; }
        .received { background-color: #2b2d31; color: #dbdee1; border-bottom-left-radius: 4px; }
        
        /* 送信時刻の表示スタイル */
        .msg-time { font-size: 10px; color: #949ba4; margin-top: 4px; }
        .time-right { align-self: flex-end; margin-right: 4px; }
        .time-left { align-self: flex-start; margin-left: 4px; }
        
        footer { background: #2b2d31; padding: 15px 20px; display: flex; gap: 12px; align-items: center; }
        #attach-btn { background: none; border: none; color: #949ba4; font-size: 22px; cursor: pointer; transition: 0.2s; }
        #attach-btn:disabled { opacity: 0.4; cursor: not-allowed; }
        #message-input { flex: 1; background: #383a40; border: none; padding: 14px 20px; border-radius: 25px; outline: none; font-size: 15px; color: white; }
        #send-btn { background: var(--theme-color, #85E249); color: #111; border: none; padding: 10px 20px; border-radius: 20px; font-weight: bold; cursor: pointer; }
        #send-btn:disabled, #message-input:disabled { opacity: 0.5; cursor: not-allowed; }
        
        #call-members-container { display: flex; gap: 5px; margin-left: 10px; flex-wrap: wrap; }
        .member-badge { background: #3f4147; color: var(--theme-color, #85E249); padding: 4px 8px; border-radius: 4px; font-size: 11px; display: flex; align-items: center; gap: 6px; border: 1px solid var(--theme-color, #85E249); }
        .member-kick { cursor: pointer; color: #da373c; font-weight: bold; font-size: 14px; }

        @keyframes pulse { 0% { transform: scale(1); } 50% { transform: scale(1.1); } 100% { transform: scale(1); } }
        .calling { color: #ff4757 !important; animation: pulse 1.2s infinite; }
        .sharing { color: var(--theme-color, #85E249) !important; animation: pulse 1.5s infinite; }
        #visualizer-canvas { width: 60px; height: 20px; vertical-align: middle; margin-left: 10px; display: none; }
        
        #incoming-call-modal { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); display: none; justify-content: center; align-items: center; z-index: 9999; backdrop-filter: blur(3px); }
        .modal-content { background: #2b2d31; padding: 30px 40px; border-radius: 12px; text-align: center; color: white; border: 1px solid #3f4147; }
        .modal-buttons { display: flex; gap: 15px; margin-top: 25px; justify-content: center; }
        .modal-btn { padding: 12px 30px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; }
        .btn-answer { background: var(--theme-color, #23a559); color: white; }
        .btn-decline { background: #da373c; color: white; }
        #toast { position: fixed; top: 20px; left: 50%; transform: translateX(-50%) translateY(-20px); background: var(--theme-color, #85E249); color: #111; padding: 10px 25px; border-radius: 30px; font-weight: bold; opacity: 0; transition: 0.4s; pointer-events: none; z-index: 10000; }
        .toast-show { opacity: 1 !important; transform: translateX(-50%) translateY(0) !important; }

        /* 新設：設定モーダル画面 (区切りを追加) */
        #settings-modal { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.85); display: none; justify-content: center; align-items: center; z-index: 20000; backdrop-filter: blur(5px); }
        .settings-content { background: #2b2d31; width: 90%; max-width: 500px; height: 85vh; border-radius: 14px; border: 1px solid #3f4147; display: flex; flex-direction: column; overflow: hidden; color: #dbdee1; }
        .settings-header { padding: 15px 20px; background: #1e1f22; font-weight: bold; font-size: 16px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #2b2d31; }
        .settings-close-btn { background: none; border: none; color: #949ba4; font-size: 20px; cursor: pointer; }
        .settings-close-btn:hover { color: white; }
        .settings-body { padding: 20px; flex: 1; overflow-y: auto; display: flex; flex-direction: column; gap: 0px; }
        
        .settings-section { border-bottom: 1px solid #3f4147; padding-bottom: 20px; margin-bottom: 20px; display: flex; flex-direction: column; gap: 10px; }
        .settings-section:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
        .settings-label { font-size: 12px; color: #949ba4; font-weight: bold; text-transform: uppercase; border-left: 3px solid var(--theme-color, #85E249); padding-left: 8px; margin-bottom: 5px; }
        
        .icon-selector { display: flex; gap: 10px; flex-wrap: wrap; }
        .icon-option { font-size: 24px; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; background: #1e1f22; border: 2px solid transparent; border-radius: 6px; cursor: pointer; transition: 0.2s; overflow: hidden; }
        .icon-option:hover { background: #3f4147; }
        .icon-option.selected { border-color: var(--theme-color, #85E249); background: #383a40; }
        
        /* 外観設定用テーマカラーセレクター */
        .theme-selector { display: flex; gap: 12px; flex-wrap: wrap; }
        .theme-color-btn { width: 30px; height: 30px; border-radius: 50%; cursor: pointer; border: 2px solid transparent; transition: 0.2s; }
        .theme-color-btn:hover { transform: scale(1.1); }
        .theme-color-btn.selected { border-color: #fff; box-shadow: 0 0 8px rgba(255,255,255,0.5); }

        .settings-history-list { display: flex; flex-direction: column; gap: 6px; max-height: 180px; overflow-y: auto; background: #1e1f22; padding: 10px; border-radius: 8px; }
        .settings-history-row { display: flex; justify-content: space-between; align-items: center; background: #2b2d31; padding: 8px 12px; border-radius: 6px; font-size: 13px; }
        .history-del-btn { background: none; border: none; color: #da373c; cursor: pointer; font-size: 16px; transition: 0.2s; }
        .history-del-btn:hover { transform: scale(1.2); }
        
        .sidebar-settings-trigger { width: 100%; padding: 10px; background: #1e1f22; border: 1px solid #3f4147; color: #dbdee1; border-radius: 6px; font-weight: bold; cursor: pointer; text-align: center; margin-top: auto; transition: 0.2s; font-size: 13px; display: flex; align-items: center; justify-content: center; gap: 6px; }
        .sidebar-settings-trigger:hover { background: #3f4147; color: white; border-color: var(--theme-color, #85E249); }
    </style>
</head>
<body>
<div id="sidebar">
    <div class="sidebar-section-title">フレンド追加</div>
    <div class="friend-add-box">
        <input type="text" id="sidebar-friend-id" placeholder="相手のID(4桁)">
        <button id="sidebar-friend-add-btn">フレンドになる</button>
    </div>
    <div class="sidebar-section-title">フレンド一覧</div>
    <div id="friend-list-container" style="width:100%; display:flex; flex-direction:column; gap:8px;"></div>
    <button class="sidebar-settings-trigger" id="open-settings-btn">⚙️ 設定メニュー</button>
</div>
<div id="main-chat">
    <div id="setup-area">
        <div style="display: flex; align-items: center;">
            マイID: <span id="my-id-display" class="id-display" style="margin-left: 5px;" title="設定からID変更可能">----</span>
            <div id="my-avatar-display" style="margin-left: 10px; width: 24px; height: 24px; display: flex; align-items: center; justify-content: center; font-size: 18px; border-radius: 50%; overflow: hidden;">👤</div>
            <canvas id="visualizer-canvas"></canvas>
        </div>
        <div style="font-weight: bold; color: #949ba4;" id="top-ver-display">v70</div>
    </div>
    <header>
        <div style="display:flex; align-items:center; overflow: hidden;">
            <span id="chat-title">フレンドを選択してください</span>
            <div id="call-members-container"></div>
        </div>
        <div style="display: flex; gap: 12px; align-items: center;">
            <button id="mic-btn" style="background:none; border:none; color:var(--theme-color, #85E249); font-size:22px; display:none; cursor:pointer;" title="マイクON/OFF">🎤</button>
            <button id="cam-btn" style="background:none; border:none; color:var(--theme-color, #85E249); font-size:22px; display:none; cursor:pointer;" title="カメラON/OFF">📹</button>
            <button id="screen-btn" style="background:none; border:none; color:white; font-size:20px; display:none; cursor:pointer;" title="画面共有">🖥️</button>
            <button id="invite-btn" style="background:none; border:none; color:var(--theme-color, #85E249); font-size:22px; display:none; cursor:pointer;" title="招待">➕</button>
            <button id="call-btn" style="background:none; border:none; color:white; font-size:22px; display:none; cursor:pointer;">📞</button>
        </div>
    </header>
    
    <div id="large-video-view">
        <video id="large-video-element" autoplay playsinline></video>
        <div class="large-video-label" id="large-video-label-text">拡大表示中</div>
    </div>

    <div id="video-grid-container">
        <div id="video-grid"></div>
    </div>

    <div id="screen-share-container">
        <video id="screen-video" autoplay playsinline muted></video>
    </div>
    <div id="chat-container"></div>
    <footer>
        <button id="attach-btn" title="画像添付" disabled>📎</button>
        <input type="file" id="file-input" style="display:none;" accept="image/*,video/*">
        <input type="text" id="message-input" placeholder="フレンドを選択してください" disabled>
        <button id="send-btn" disabled>送信</button>
    </footer>
</div>

<div id="incoming-call-modal">
    <div class="modal-content">
        <h3 style="margin-bottom:10px; color:var(--theme-color, #85E249);">📞 通話着信</h3>
        <p><span id="caller-name-display">相手</span></p>
        <div class="modal-buttons">
            <button class="modal-btn btn-decline" id="decline-btn">拒否</button>
            <button class="modal-btn btn-answer" id="answer-btn">応答</button>
        </div>
    </div>
</div>

<div id="settings-modal">
    <div class="settings-content">
        <div class="settings-header">
            <span>⚙️ 設定メニュー</span>
            <button class="settings-close-btn" id="close-settings-btn">×</button>
        </div>
        <div class="settings-body">
            
            <div class="settings-section">
                <div class="settings-label">プロフィール設定</div>
                <input type="text" id="settings-my-nickname" placeholder="名前を入力" style="width:100%; background:#1e1f22;">
                
                <div style="display:flex; gap:8px; margin-top:5px;">
                    <input type="text" id="settings-my-id-input" placeholder="新しい4桁ID" style="flex:1; background:#1e1f22;">
                    <button id="settings-id-change-btn" style="background:var(--theme-color, #85E249); color:#111; border:none; padding:6px 12px; border-radius:6px; font-weight:bold; cursor:pointer; font-size:13px;">ID変更を確定</button>
                </div>
            </div>

            <div class="settings-section">
                <div class="settings-label">外見アイコンの変更</div>
                <div class="icon-selector" id="settings-icon-selector">
                    <span class="icon-option" data-icon="👤">👤</span>
                    <span class="icon-option" data-icon="🦊">🦊</span>
                    <span class="icon-option" data-icon="🐱">🐱</span>
                    <span class="icon-option" data-icon="🤖">🤖</span>
                    <span class="icon-option" data-icon="🎮">🎮</span>
                    <span class="icon-option" data-icon="🚀">🚀</span>
                </div>
                <div id="custom-icon-dropzone" style="border: 2px dashed #3f4147; border-radius: 8px; padding: 15px; text-align: center; color: #949ba4; font-size: 12px; cursor: pointer; margin-top: 5px; transition: 0.2s; background: #1e1f22;">
                    または画像をドロップしてカスタムアイコンを設定<br>(クリックでファイル選択)
                </div>
            </div>

            <div class="settings-section">
                <div class="settings-label">外観カラー（テーマ）設定</div>
                <div class="theme-selector" id="theme-selector-box">
                    <div class="theme-color-btn" style="background:#85E249;" data-color="#85E249" title="グリーン"></div>
                    <div class="theme-color-btn" style="background:#3498db;" data-color="#3498db" title="ブルー"></div>
                    <div class="theme-color-btn" style="background:#e74c3c;" data-color="#e74c3c" title="レッド"></div>
                    <div class="theme-color-btn" style="background:#f1c40f;" data-color="#f1c40f" title="イエロー"></div>
                    <div class="theme-color-btn" style="background:#9b59b6;" data-color="#9b59b6" title="パープル"></div>
                    <div class="theme-color-btn" style="background:#ff9ff3;" data-color="#ff9ff3" title="ピンク"></div>
                </div>
            </div>

            <div class="settings-section">
                <div class="settings-label">チャット履歴・フレンド管理</div>
                <div class="settings-history-list" id="settings-history-list-box"></div>
            </div>
            
        </div>
    </div>
</div>

<style id="dynamic-theme"></style>

<div id="toast"></div>

<script>
    const VER = "v70"; 
    const PREFIX = "p2p_stable_v70_"; 

    // テーマカラー管理機能
    let currentThemeColor = localStorage.getItem('my_theme_color') || '#85E249';
    function applyTheme(color) {
        currentThemeColor = color;
        localStorage.setItem('my_theme_color', color);
        document.documentElement.style.setProperty('--theme-color', color);
        
        // JS内での明示的な上書き用
        let style = document.getElementById('dynamic-theme');
        style.innerHTML = `
            .history-item.active { background: ${color} !important; color: #111 !important; }
            .id-display { color: ${color} !important; }
            #send-btn { background: ${color} !important; }
            .sent { background-color: ${color} !important; color: #111 !important; }
            .member-badge { color: ${color} !important; border-color: ${color} !important; }
            .sharing { color: ${color} !important; }
            #sidebar-friend-add-btn { background: ${color} !important; }
            #settings-id-change-btn { background: ${color} !important; }
            .icon-option.selected { border-color: ${color} !important; }
            #large-video-view { border-bottom-color: ${color} !important; }
            .large-video-label { color: ${color} !important; }
            .video-card:hover { border-color: ${color} !important; }
            .toast-show { background: ${color} !important; }
            h3 { color: ${color} !important; }
            .btn-answer { background: ${color} !important; color: #111 !important; }
        `;
        
        document.querySelectorAll('.theme-color-btn').forEach(btn => {
            if(btn.getAttribute('data-color') === color) btn.classList.add('selected');
            else btn.classList.remove('selected');
        });
    }
    applyTheme(currentThemeColor);

    document.querySelectorAll('.theme-color-btn').forEach(btn => {
        btn.onclick = () => applyTheme(btn.getAttribute('data-color'));
    });

    // データ移行 (v60〜v69のデータをv70へ完全引き継ぎ)
    if (!localStorage.getItem('migrated_to_'+VER)) {
        const oldVersions = ["v60", "v61", "v62", "v63", "v64", "v65", "v66", "v67", "v68", "v69"];
        let foundFriends = null;
        for (let v of oldVersions) {
            let f = localStorage.getItem('friends_' + v);
            if (f) { foundFriends = f; break; }
        }
        if (foundFriends) {
            try {
                let parsed = JSON.parse(foundFriends);
                Object.keys(parsed).forEach(k => {
                    if(!parsed[k].icon) parsed[k].icon = "👤";
                });
                localStorage.setItem('friends_' + VER, JSON.stringify(parsed));
            } catch(e) {
                localStorage.setItem('friends_' + VER, foundFriends);
            }
        }
        localStorage.setItem('migrated_to_'+VER, 'true');
    }

    let myNumber = localStorage.getItem('my_permanent_chat_id') || Math.floor(1000 + Math.random() * 9000).toString();
    localStorage.setItem('my_permanent_chat_id', myNumber);
    document.getElementById('my-id-display').textContent = myNumber;
    document.getElementById('settings-my-id-input').value = myNumber;

    document.getElementById('my-id-display').onclick = () => {
        openSettingsModal();
    };

    let myNickname = localStorage.getItem('my_permanent_nick') || "名無し";
    document.getElementById('settings-my-nickname').value = myNickname;
    document.getElementById('settings-my-nickname').oninput = (e) => {
        localStorage.setItem('my_permanent_nick', e.target.value);
        myNickname = e.target.value;
        broadcastUserInfo();
    };

    let myIcon = localStorage.getItem('my_permanent_icon') || "👤";
    document.getElementById('my-avatar-display').innerHTML = myIcon;

    const peer = new Peer(PREFIX + myNumber, {
        config: {'iceServers': [{ 'urls': 'stun:stun.l.google.com:19302' }]},
        debug: 1
    });

    let connections = {}, activePeer = null, localStream = null, screenStream = null;
    let activeCalls = {}, isMicMuted = false, isCamOff = true;
    
    let globalAudioCtx = null;
    let animationId;
    let remoteAnalysers = {}; 
    let localAnalyser = null;
    let localAudioSource = null;
    let isMediaSwitching = false;
    let currentlyExpandedPeer = null; 

    // ★バグ・ラグ修正: 映像ストリームを裏側でキャッシュして再描画地獄を防ぐ
    let remoteStreamsCache = {};

    let toastTimeout = null;
    function showToast(m) { 
        const t = document.getElementById('toast'); 
        t.textContent = m; 
        t.classList.add('toast-show'); 
        if (toastTimeout) clearTimeout(toastTimeout);
        toastTimeout = setTimeout(() => t.classList.remove('toast-show'), 3000); 
    }

    window.heldCalls = {};

    function checkHeldCalls() {
        const f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        Object.keys(window.heldCalls).forEach(id => {
            if (connections[id]?.open || f[id]) {
                let call = window.heldCalls[id];
                delete window.heldCalls[id];
                setupCallUI(call);
                let streamToAnswer = localStream;
                if (screenStream) {
                    streamToAnswer = new MediaStream();
                    if (localStream && localStream.getAudioTracks().length > 0) streamToAnswer.addTrack(localStream.getAudioTracks()[0]);
                    if (screenStream && screenStream.getVideoTracks().length > 0) streamToAnswer.addTrack(screenStream.getVideoTracks()[0]);
                }
                call.answer(streamToAnswer);
            }
        });
    }

    function getAudioCtx() {
        if (!globalAudioCtx) globalAudioCtx = new (window.AudioContext || window.webkitAudioContext)();
        if (globalAudioCtx.state === 'suspended') globalAudioCtx.resume();
        return globalAudioCtx;
    }

    const callBtn = document.getElementById('call-btn'), micBtn = document.getElementById('mic-btn'), camBtn = document.getElementById('cam-btn');
    const screenBtn = document.getElementById('screen-btn'), inviteBtn = document.getElementById('invite-btn');
    const input = document.getElementById('message-input'), sendBtn = document.getElementById('send-btn'), attachBtn = document.getElementById('attach-btn');
    const canvas = document.getElementById('visualizer-canvas'), ctx = canvas.getContext('2d');
    const screenContainer = document.getElementById('screen-share-container'), screenVideo = document.getElementById('screen-video');

    peer.on('open', () => { renderHistory(); let f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}"); Object.keys(f).forEach(n => { if (n !== myNumber) tryConnect(n); }); });

    peer.on('connection', (conn) => {
        const num = conn.peer.replace(PREFIX, "");
        addFriend(num, null); setupConn(conn, num);
    });

    peer.on('call', (call) => {
        const callerId = call.peer.replace(PREFIX, "");
        const oldCall = activeCalls[callerId];
        const isCalling = localStream !== null || Object.keys(activeCalls).length > 0 || callBtn.classList.contains('calling');
        const f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");

        if (isCalling) {
            if (connections[callerId]?.open || oldCall || f[callerId]) {
                setupCallUI(call);
                setTimeout(() => { if (oldCall && oldCall !== call) oldCall.close(); }, 1500); 

                let streamToAnswer = localStream;
                if (screenStream) {
                    streamToAnswer = new MediaStream();
                    if (localStream && localStream.getAudioTracks().length > 0) {
                        streamToAnswer.addTrack(localStream.getAudioTracks()[0]);
                    }
                    if (screenStream.getVideoTracks().length > 0) {
                        streamToAnswer.addTrack(screenStream.getVideoTracks()[0]);
                    }
                }
                call.answer(streamToAnswer);
                return;
            } else {
                window.heldCalls[callerId] = call;
                setTimeout(() => {
                    if (window.heldCalls[callerId]) {
                        window.heldCalls[callerId].close();
                        delete window.heldCalls[callerId];
                    }
                }, 4000);
                return; 
            }
        }
        
        if (oldCall) oldCall.close();
        document.getElementById('caller-name-display').textContent = (f[callerId]?.name || callerId) + " からの着信";
        const modal = document.getElementById('incoming-call-modal');
        modal.style.display = 'flex';
        modal.style.zIndex = '9999';
        window.pendingCall = call;
    });

    document.getElementById('answer-btn').onclick = async () => {
        document.getElementById('incoming-call-modal').style.display = 'none';
        getAudioCtx(); 
        try {
            const callerId = window.pendingCall.peer.replace(PREFIX, "");
            if (connections[callerId]?.open) {
                connections[callerId].send({ type: 'sys-call-accepted' });
            }
            localStream = await navigator.mediaDevices.getUserMedia({ audio: { echoCancellation: true, sampleRate: 48000 } });
            if (localStream && localStream.getAudioTracks().length > 0) {
                localStream.getAudioTracks()[0].enabled = !isMicMuted;
            }
            startVisualizer(localStream);
            setupCallUI(window.pendingCall);
            window.pendingCall.answer(localStream);
            setTimeout(broadcastMesh, 1000);
            updateVideoGridUI();
        } catch (e) { showToast("マイクを許可してください"); }
    };

    document.getElementById('decline-btn').onclick = () => {
        document.getElementById('incoming-call-modal').style.display = 'none';
        if (window.pendingCall) {
            const callerId = window.pendingCall.peer.replace(PREFIX, "");
            if (connections[callerId]?.open) {
                connections[callerId].send({ type: 'sys-call-declined' });
            } else {
                const tempConn = peer.connect(PREFIX + callerId, { reliable: true });
                tempConn.on('open', () => {
                    tempConn.send({ type: 'sys-call-declined' });
                    setTimeout(() => tempConn.close(), 1000);
                });
            }
            window.pendingCall.close();
            window.pendingCall = null;
        }
    };

    function tryConnect(num) {
        if (connections[num]?.open) return;
        setupConn(peer.connect(PREFIX + num, { reliable: true }), num);
    }

    function setupConn(conn, num) {
        conn.on('open', () => { 
            connections[num] = conn; 
            renderHistory(); 
            if(activePeer === num) updateInputStatus(); 
            checkHeldCalls();
            broadcastUserInfo();
        });
        
        conn.on('close', () => { if (connections[num] === conn) { delete connections[num]; renderHistory(); updateInputStatus(); }});
        conn.on('error', () => { if (connections[num] === conn) { delete connections[num]; renderHistory(); updateInputStatus(); }});

        conn.on('data', (data) => {
            if (data?.type === 'sys-call-accepted') {
                showToast("通話が承諾されました");
                return;
            }
            if (data?.type === 'sys-call-declined') {
                showToast("通話が拒否されました");
                endAllCalls();
                return;
            }
            if (data?.type === 'sys-user-info') {
                updateFriendMeta(num, data.name, data.icon);
                return;
            }
            if (data?.type === 'sys-mesh') {
                data.participants.forEach(p => { 
                    if (p !== myNumber) {
                        addFriend(p, null);
                        if (!connections[p]?.open && myNumber > p) {
                            tryConnect(p); 
                        }
                        if (!activeCalls[p] && localStream) {
                            if (myNumber > p) {
                                let streamToSend = localStream;
                                if (screenStream) {
                                    streamToSend = new MediaStream();
                                    if (localStream && localStream.getAudioTracks().length > 0) {
                                        streamToSend.addTrack(localStream.getAudioTracks()[0]);
                                    }
                                    if (screenStream && screenStream.getVideoTracks().length > 0) {
                                        streamToSend.addTrack(screenStream.getVideoTracks()[0]);
                                    }
                                }
                                setupCallUI(peer.call(PREFIX + p, streamToSend));
                            }
                        }
                    }
                });
                checkHeldCalls(); 
                return;
            }
            if (data?.content || data?.type === 'file') { addFriend(num, data.senderName); saveMsg(num, data, 'received'); if (activePeer === num) renderChat(); renderHistory(); }
        });
    }

    function broadcastUserInfo() {
        Object.values(connections).forEach(conn => {
            if (conn.open) {
                conn.send({ type: 'sys-user-info', name: myNickname, icon: myIcon });
            }
        });
    }

    function updateFriendMeta(num, name, icon) {
        let f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        if (f[num]) {
            if (name) f[num].name = name;
            if (icon) f[num].icon = icon;
            localStorage.setItem('friends_'+VER, JSON.stringify(f));
            renderHistory();
            updateVideoGridUI();
        }
    }

    micBtn.onclick = () => {
        isMicMuted = !isMicMuted;
        if (localStream && localStream.getAudioTracks().length > 0) {
            localStream.getAudioTracks()[0].enabled = !isMicMuted;
        }
        micBtn.textContent = isMicMuted ? "🔇" : "🎤";
        micBtn.style.color = isMicMuted ? "#da373c" : "var(--theme-color, #85E249)";
    };

    camBtn.onclick = async () => {
        if (!localStream || isMediaSwitching) return;
        isMediaSwitching = true;
        setTimeout(() => { isMediaSwitching = false; }, 2000);
        
        if (isCamOff) {
            try {
                const vs = await navigator.mediaDevices.getUserMedia({ video: { width: 640, height: 480 } });
                const videoTrack = vs.getVideoTracks()[0];
                localStream.addTrack(videoTrack);
                isCamOff = false;
                camBtn.textContent = "📷";
                camBtn.style.color = "var(--theme-color, #85E249)";
                
                let streamToSend = localStream;
                if (screenStream) {
                    streamToSend = new MediaStream();
                    if (localStream.getAudioTracks().length > 0) streamToSend.addTrack(localStream.getAudioTracks()[0]);
                    streamToSend.addTrack(screenStream.getVideoTracks()[0]);
                }

                Object.keys(activeCalls).forEach(id => {
                    const oldCall = activeCalls[id];
                    setupCallUI(peer.call(PREFIX + id, streamToSend));
                    setTimeout(() => { if (oldCall && oldCall !== activeCalls[id]) oldCall.close(); }, 1500);
                });
                updateVideoGridUI();
            } catch (e) { 
                showToast("カメラが使えません"); 
                isMediaSwitching = false;
            }
        } else {
            localStream.getVideoTracks().forEach(t => { t.stop(); localStream.removeTrack(t); });
            isCamOff = true;
            camBtn.textContent = "📹";
            camBtn.style.color = "#da373c";
            
            let streamToSend = localStream;
            if (screenStream) {
                streamToSend = new MediaStream();
                if (localStream.getAudioTracks().length > 0) streamToSend.addTrack(localStream.getAudioTracks()[0]);
                streamToSend.addTrack(screenStream.getVideoTracks()[0]);
            }

            Object.keys(activeCalls).forEach(id => {
                const oldCall = activeCalls[id];
                setupCallUI(peer.call(PREFIX + id, streamToSend));
                setTimeout(() => { if (oldCall && oldCall !== activeCalls[id]) oldCall.close(); }, 1500);
            });
            updateVideoGridUI();
        }
    };

    function setupCallUI(call) {
        const peerId = call.peer.replace(PREFIX, "");
        activeCalls[peerId] = call;
        callBtn.textContent = "🔴"; callBtn.classList.add('calling');
        micBtn.style.display = camBtn.style.display = screenBtn.style.display = inviteBtn.style.display = 'block';

        call.on('stream', (stream) => { 
            let audioEl = document.getElementById('audio_' + peerId);
            if (audioEl) {
                audioEl.pause();
                audioEl.srcObject = null;
                audioEl.remove();
            }
            
            if (remoteAnalysers[peerId]) {
                try { remoteAnalysers[peerId].disconnect(); } catch(e){}
                delete remoteAnalysers[peerId];
            }

            // ★バグ・ラグ修正: ストリームのキャッシュ保存
            remoteStreamsCache[peerId] = stream;

            audioEl = document.createElement('audio');
            audioEl.id = 'audio_' + peerId;
            audioEl.autoplay = true;
            audioEl.setAttribute('playsinline', 'true');
            document.body.appendChild(audioEl);
            audioEl.srcObject = stream;
            audioEl.play().catch(() => {});

            if (stream.getAudioTracks().length > 0) {
                try {
                    const actx = getAudioCtx();
                    const rAnl = actx.createAnalyser();
                    rAnl.fftSize = 32;
                    const rSrc = actx.createMediaStreamSource(stream);
                    rSrc.connect(rAnl);
                    remoteAnalysers[peerId] = rAnl;
                } catch(e) {}
            }
            updateCallMemberListUI();
            updateVideoGridUI();
        });
        
        call.on('close', () => {
            if (activeCalls[peerId] === call) removeCall(peerId);
        });
        updateCallMemberListUI();
        updateVideoGridUI();
    }

    function removeCall(id) {
        if(activeCalls[id]) activeCalls[id].close(); delete activeCalls[id];
        delete remoteStreamsCache[id]; // キャッシュクリア
        
        if(remoteAnalysers[id]) {
            try { remoteAnalysers[id].disconnect(); } catch(e){}
            delete remoteAnalysers[id];
        }
        const el = document.getElementById('audio_' + id); 
        if(el) {
            el.pause();
            el.srcObject = null;
            el.remove();
        }
        if (currentlyExpandedPeer === id) {
            closeLargeVideo();
        }
        if(Object.keys(activeCalls).length === 0) endAllCalls(); else { updateCallMemberListUI(); updateVideoGridUI(); }
    }

    function endAllCalls() {
        Object.values(activeCalls).forEach(c => c.close()); activeCalls = {};
        remoteStreamsCache = {};
        
        Object.keys(remoteAnalysers).forEach(id => {
            try { remoteAnalysers[id].disconnect(); } catch(e){}
        });
        remoteAnalysers = {}; 
        
        if (localStream) { 
            localStream.getTracks().forEach(t => {
                t.stop();
                localStream.removeTrack(t);
            }); 
            localStream = null; 
        }
        
        isMicMuted = false;
        micBtn.textContent = "🎤";
        micBtn.style.color = "var(--theme-color, #85E249)";
        
        stopScreenShare(); stopVisualizer(); closeLargeVideo();
        callBtn.textContent = "📞"; callBtn.classList.remove('calling');
        micBtn.style.display = camBtn.style.display = screenBtn.style.display = inviteBtn.style.display = 'none';
        isCamOff = true; camBtn.textContent = "📹";
        camBtn.style.color = "#da373c";
        document.getElementById('call-members-container').innerHTML = "";
        document.getElementById('video-grid-container').style.display = 'none';
    }

    function updateCallMemberListUI() {
        const c = document.getElementById('call-members-container'); c.innerHTML = "";
        const f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        Object.keys(activeCalls).forEach(id => {
            const b = document.createElement('div'); b.className = 'member-badge';
            b.innerHTML = `<span class="video-card-name-icon">${f[id]?.icon || "👤"}</span><span>${f[id]?.name || id}</span><canvas id="remote-vis-${id}" width="40" height="15" style="vertical-align:middle; margin-left:8px; margin-right:4px; display:inline-block;"></canvas><span class="member-kick" title="切断">×</span>`;
            b.querySelector('.member-kick').onclick = (e) => { e.stopPropagation(); removeCall(id); };
            c.appendChild(b);
        });
    }

    // ★バグ・ラグ修正: 連続呼び出しを間引くデバウンス処理
    let videoGridTimeout = null;
    function updateVideoGridUI() {
        if(videoGridTimeout) clearTimeout(videoGridTimeout);
        videoGridTimeout = setTimeout(doUpdateVideoGridUI, 150);
    }

    // メンバーごとの個別ビデオ・画面共有枠をグリッド表示するコア処理
    function doUpdateVideoGridUI() {
        const grid = document.getElementById('video-grid');
        const container = document.getElementById('video-grid-container');
        
        if (Object.keys(activeCalls).length === 0 && !localStream) {
            container.style.display = 'none';
            return;
        }
        container.style.display = 'block';
        
        grid.innerHTML = "";
        const f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");

        // 1. 自分自身の枠
        if (localStream && (!isCamOff || screenStream)) {
            const myCard = document.createElement('div');
            myCard.className = `video-card ${currentlyExpandedPeer === 'me' ? 'selected-large' : ''}`;
            myCard.onclick = () => toggleExpandVideo('me', localStream || screenStream);

            if (!isCamOff) {
                const v = document.createElement('video');
                v.autoplay = true; v.playsinline = true; v.muted = true;
                v.srcObject = localStream;
                myCard.appendChild(v);
            } else {
                const av = document.createElement('div');
                av.className = 'video-card-avatar';
                av.innerHTML = myIcon;
                myCard.appendChild(av);
            }
            
            const info = document.createElement('div');
            info.className = 'video-card-info';
            info.innerHTML = `<span class="video-card-name"><span class="video-card-name-icon">${myIcon}</span>${myNickname}(自分)</span><span>${screenStream ? '🖥️' : '📹'}</span>`;
            myCard.appendChild(info);
            grid.appendChild(myCard);
        }

        // 2. 通話相手全員の個別枠
        Object.keys(activeCalls).forEach(id => {
            const friend = f[id] || { name: id, icon: "👤" };
            const card = document.createElement('div');
            card.className = `video-card ${currentlyExpandedPeer === id ? 'selected-large' : ''}`;
            
            // ★バグ修正: キャッシュした安全なストリームを直接使用
            let remoteStream = remoteStreamsCache[id];

            card.onclick = () => {
                if (remoteStream) toggleExpandVideo(id, remoteStream);
            };

            const hasVideo = remoteStream && remoteStream.getVideoTracks().length > 0;
            if (hasVideo) {
                const v = document.createElement('video');
                v.autoplay = true; v.playsinline = true;
                v.srcObject = remoteStream;
                card.appendChild(v);
            } else {
                const av = document.createElement('div');
                av.className = 'video-card-avatar';
                av.innerHTML = friend.icon || "👤";
                card.appendChild(av);
            }

            const info = document.createElement('div');
            info.className = 'video-card-info';
            info.innerHTML = `<span class="video-card-name"><span class="video-card-name-icon">${friend.icon || "👤"}</span>${friend.name}</span><span>${hasVideo ? '📹' : '🎙️'}</span>`;
            card.appendChild(info);
            grid.appendChild(card);
        });
    }

    // 特定のプレイヤーの映像を大きく表示・トグルする機能
    function toggleExpandVideo(id, stream) {
        const largeView = document.getElementById('large-video-view');
        const largeVideo = document.getElementById('large-video-element');
        const largeLabel = document.getElementById('large-video-label-text');
        const f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");

        if (currentlyExpandedPeer === id) {
            closeLargeVideo();
            return;
        }

        if (stream && stream.getVideoTracks().length > 0) {
            currentlyExpandedPeer = id;
            largeView.style.display = 'block';
            largeVideo.srcObject = stream;
            
            let name = id === 'me' ? myNickname : (f[id]?.name || id);
            let icon = id === 'me' ? myIcon : (f[id]?.icon || "👤");
            largeLabel.innerHTML = `<span class="video-card-name-icon">${icon}</span> ${name} の画面を拡大表示中`;
            updateVideoGridUI();
        } else {
            showToast("このユーザーは映像を送信していません");
        }
    }

    function closeLargeVideo() {
        currentlyExpandedPeer = null;
        document.getElementById('large-video-view').style.display = 'none';
        document.getElementById('large-video-element').srcObject = null;
        updateVideoGridUI();
    }

    callBtn.onclick = async () => {
        if (callBtn.disabled) return;
        if (Object.keys(activeCalls).length > 0) { endAllCalls(); return; }
        getAudioCtx();
        try {
            localStream = await navigator.mediaDevices.getUserMedia({ audio: { echoCancellation: true, sampleRate: 48000 } });
            if (localStream && localStream.getAudioTracks().length > 0) {
                localStream.getAudioTracks()[0].enabled = !isMicMuted;
            }
            startVisualizer(localStream);
            setupCallUI(peer.call(PREFIX + activePeer, localStream));
            setTimeout(broadcastMesh, 1000);
            updateVideoGridUI();
        } catch (e) { showToast("マイクを許可してください"); }
    };

    inviteBtn.onclick = () => {
        const target = prompt("招待する相手のID:");
        if (target && target !== myNumber) {
            addFriend(target, null);
            tryConnect(target);
            if (localStream) {
                setTimeout(() => {
                    const oldCall = activeCalls[target];
                    let streamToSend = localStream;
                    if (screenStream) {
                        streamToSend = new MediaStream();
                        if (localStream.getAudioTracks().length > 0) streamToSend.addTrack(localStream.getAudioTracks()[0]);
                        streamToSend.addTrack(screenStream.getVideoTracks()[0]);
                    }
                    setupCallUI(peer.call(PREFIX + target, streamToSend));
                    setTimeout(() => { if (oldCall && oldCall !== activeCalls[target]) oldCall.close(); }, 1500);
                    setTimeout(broadcastMesh, 1500);
                }, 800);
            }
        }
    };

    function startVisualizer(s) {
        if (animationId) cancelAnimationFrame(animationId);
        const actx = getAudioCtx();
        if (localAnalyser) { try { localAnalyser.disconnect(); } catch(e){} }
        if (localAudioSource) { try { localAudioSource.disconnect(); } catch(e){} }

        localAnalyser = actx.createAnalyser();
        localAudioSource = actx.createMediaStreamSource(s);
        localAudioSource.connect(localAnalyser);
        localAnalyser.fftSize = 32;
        
        const data = new Uint8Array(localAnalyser.frequencyBinCount);
        canvas.style.display = 'inline-block';
        
        const draw = () => {
            animationId = requestAnimationFrame(draw);
            localAnalyser.getByteFrequencyData(data);
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = currentThemeColor;
            for (let i = 0; i < data.length; i++) ctx.fillRect(i * 4, canvas.height - data[i]/6, 3, data[i]/6);

            Object.keys(remoteAnalysers).forEach(id => {
                const rAnl = remoteAnalysers[id];
                const rCanv = document.getElementById('remote-vis-' + id);
                if (rAnl && rCanv) {
                    const rCtx = rCanv.getContext('2d');
                    const rData = new Uint8Array(rAnl.frequencyBinCount);
                    rAnl.getByteFrequencyData(rData);
                    rCtx.clearRect(0, 0, rCanv.width, rCanv.height);
                    rCtx.fillStyle = '#f1c40f'; 
                    for (let i = 0; i < rData.length; i++) rCtx.fillRect(i * 3, rCanv.height - rData[i]/8, 2, rData[i]/8);
                }
            });
        };
        draw();
    }

    function stopVisualizer() { 
        if(animationId) cancelAnimationFrame(animationId); 
        animationId = null;
        canvas.style.display = 'none'; 
    }

    function broadcastMesh() {
        const ps = [...Object.keys(activeCalls), myNumber];
        ps.forEach(id => { if(connections[id]?.open) connections[id].send({ type: 'sys-mesh', participants: ps }); });
    }

    screenBtn.onclick = async () => {
        if (isMediaSwitching) return;
        isMediaSwitching = true;
        setTimeout(() => { isMediaSwitching = false; }, 2000); 

        if (screenStream) { stopScreenShare(); return; }
        try {
            screenStream = await navigator.mediaDevices.getDisplayMedia({ video: { width: 854, height: 480, frameRate: 10 } });
            screenBtn.classList.add('sharing'); 
            
            const combinedStream = new MediaStream();
            if (localStream && localStream.getAudioTracks().length > 0) {
                combinedStream.addTrack(localStream.getAudioTracks()[0]);
            }
            combinedStream.addTrack(screenStream.getVideoTracks()[0]);

            Object.keys(activeCalls).forEach(id => {
                const oldCall = activeCalls[id];
                setupCallUI(peer.call(PREFIX + id, combinedStream));
                setTimeout(() => { if (oldCall && oldCall !== activeCalls[id]) oldCall.close(); }, 1500);
            });
            screenStream.getVideoTracks()[0].onended = () => stopScreenShare();
            updateVideoGridUI();
        } catch (e) { 
            showToast("共有キャンセル"); 
            isMediaSwitching = false;
        }
    };

    function stopScreenShare() {
        if (!screenStream) return; 
        screenStream.getTracks().forEach(t => t.stop()); 
        screenStream = null;
        screenBtn.classList.remove('sharing'); 
        
        if (currentlyExpandedPeer === 'me') closeLargeVideo();

        if (localStream && Object.keys(activeCalls).length > 0) {
            Object.keys(activeCalls).forEach(id => {
                const oldCall = activeCalls[id];
                setupCallUI(peer.call(PREFIX + id, localStream));
                setTimeout(() => { if (oldCall && oldCall !== activeCalls[id]) oldCall.close(); }, 1500);
            });
        }
        updateVideoGridUI();
    }

    function addFriend(num, name) {
        let f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        if (!f[num]) f[num] = { name: num, fav: false, icon: "👤" };
        if (name) f[num].name = name;
        localStorage.setItem('friends_'+VER, JSON.stringify(f)); 
        renderHistory();
    }

    // 左側サイドバー（フレンド欄）の描画処理
    function renderHistory() {
        const f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        const container = document.getElementById('friend-list-container');
        container.innerHTML = "";
        
        Object.keys(f).sort((a, b) => (f[b].fav ? 1 : 0) - (f[a].fav ? 1 : 0)).forEach(num => {
            const b = document.createElement('div'); 
            b.className = `history-item ${activePeer === num ? 'active' : ''}`;
            const online = connections[num]?.open;
            const currentIcon = f[num].icon || "👤";
            
            b.innerHTML = `<div style="display:flex; align-items:center; overflow:hidden;"><div class="status-dot ${online ? 'status-online' : ''}"></div><span class="friend-icon-span">${currentIcon}</span><span style="overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">${f[num].name || num}</span></div><span class="fav-star ${f[num].fav ? 'is-fav' : ''}" onclick="toggleFav('${num}', event)">★</span>`;
            b.onclick = () => selectChat(num); 
            container.appendChild(b);
        });
    }

    function toggleFav(n, e) { 
        e.stopPropagation(); 
        let f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}"); 
        f[n].fav = !f[n].fav; 
        localStorage.setItem('friends_'+VER, JSON.stringify(f)); 
        renderHistory(); 
    }
    
    function selectChat(num) {
        activePeer = num; tryConnect(num); updateInputStatus();
        const f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        document.getElementById('chat-title').innerHTML = `<span class="video-card-name-icon">${f[num]?.icon || "👤"}</span> ${f[num]?.name || num}`;
        callBtn.style.display = 'block'; 
        renderChat();
    }

    function updateInputStatus() {
        const ok = connections[activePeer]?.open;
        input.disabled = sendBtn.disabled = attachBtn.disabled = callBtn.disabled = !ok;
        callBtn.style.opacity = ok ? "1" : "0.4";
        input.placeholder = ok ? "メッセージ..." : "オフライン";
    }

    // ★機能追加: メッセージにタイムスタンプを付与して保存
    function saveMsg(num, msg, type) {
        let log = JSON.parse(localStorage.getItem('log_'+VER+'_'+num) || "[]");
        log.push({ ...msg, chatType: type });
        if (log.length > 50) log = log.slice(-50);
        try {
            localStorage.setItem('log_'+VER+'_'+num, JSON.stringify(log));
        } catch (e) {
            log = log.slice(-25);
            localStorage.setItem('log_'+VER+'_'+num, JSON.stringify(log));
        }
        buildSettingsHistoryList(); 
    }

    function formatMessage(text) {
        let esc = text.replace(/[&<>"']/g, m => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m]));
        return esc.replace(/(https?:\/\/[^\s]+)/g, url => {
            if (/\.(jpeg|jpg|gif|png|webp)$/i.test(url)) return `<a href="${url}" target="_blank"><img src="${url}" style="max-width:100%; border-radius:8px; margin-bottom:5px; max-height:200px; display:block;"></a><a href="${url}" target="_blank" style="color:var(--theme-color, #85E249); font-size:12px;">${url}</a>`;
            if (/\.(mp4|webm|ogg)$/i.test(url)) return `<video src="${url}" controls style="max-width:100%; border-radius:8px; margin-bottom:5px; max-height:250px; display:block;"></video><a href="${url}" target="_blank" style="color:var(--theme-color, #85E249); font-size:12px;">${url}</a>`;
            const ytMatch = url.match(/(?:youtube\.com\/watch\?v=|youtu\.be\/)([\w-]+)/);
            if(ytMatch) return `<iframe width="280" height="157" src="https://www.youtube.com/embed/${ytMatch[1]}" frameborder="0" allowfullscreen style="border-radius:8px; margin-bottom:5px; display:block;"></iframe><a href="${url}" target="_blank" style="color:var(--theme-color, #85E249); font-size:12px;">${url}</a>`;
            return `<a href="${url}" target="_blank" style="color:var(--theme-color, #85E249); text-decoration:underline;">${url}</a>`;
        });
    }

    // ★機能追加: チャットの描画時に送信時刻（HH:MM）を表示する
    function renderChat() {
        const c = document.getElementById('chat-container'); c.innerHTML = "";
        if (!activePeer) return;
        let log = JSON.parse(localStorage.getItem('log_'+VER+'_'+activePeer) || "[]");
        log.forEach(m => {
            const w = document.createElement('div'); w.className = `msg-wrapper ${m.chatType === 'received' ? 'received-wrapper' : 'sent-wrapper'}`;
            const msg = document.createElement('div'); msg.className = `msg ${m.chatType === 'received' ? 'received' : 'sent'}`;
            if (m.type === 'file') {
                if (m.fileType === 'image') msg.innerHTML = `<img src="${m.content}" style="max-width:100%; border-radius:8px; max-height:200px;" onclick="window.open('${m.content}')">`;
                else if (m.fileType === 'video') msg.innerHTML = `<video src="${m.content}" controls style="max-width:100%; border-radius:8px;"></video>`;
                else msg.textContent = "📎 ファイルを受信しました";
            } else {
                msg.innerHTML = formatMessage(m.content);
            }
            w.appendChild(msg); 
            
            // 時刻の追加
            if (m.timestamp) {
                const d = new Date(m.timestamp);
                const tDiv = document.createElement('div');
                tDiv.className = `msg-time ${m.chatType === 'received' ? 'time-left' : 'time-right'}`;
                tDiv.textContent = `${d.getHours().toString().padStart(2, '0')}:${d.getMinutes().toString().padStart(2, '0')}`;
                w.appendChild(tDiv);
            }

            c.appendChild(w);
        });
        c.scrollTop = c.scrollHeight;
    }

    // ボタン一つで一発フレンド登録するUIロジック
    document.getElementById('sidebar-friend-add-btn').onclick = () => {
        const t = document.getElementById('sidebar-friend-id').value.trim();
        if (t && t !== myNumber) {
            addFriend(t, null);
            selectChat(t);
            document.getElementById('sidebar-friend-id').value = "";
            showToast(`ID: ${t} をフレンド登録して接続中...`);
        }
    };

    sendBtn.onclick = () => {
        const text = input.value.trim();
        if (text && connections[activePeer]?.open) {
            const m = { type: 'text', content: text, senderName: myNickname, timestamp: Date.now() }; // 時刻追加
            connections[activePeer].send(m); saveMsg(activePeer, m, 'sent'); input.value = ""; renderChat();
        }
    };
    input.onkeypress = (e) => { if(e.key === 'Enter') sendBtn.onclick(); };
    attachBtn.onclick = () => document.getElementById('file-input').click();
    document.getElementById('file-input').onchange = (e) => {
        const file = e.target.files[0];
        if (file && activePeer && file.size <= 2 * 1024 * 1024) {
            const r = new FileReader(); r.onload = (ev) => {
                const m = { type: 'file', content: ev.target.result, fileType: file.type.split('/')[0], senderName: myNickname, timestamp: Date.now() };
                connections[activePeer].send(m); saveMsg(activePeer, m, 'sent'); renderChat();
            };
            r.readAsDataURL(file);
        } else { showToast("2MB以下にしてください"); }
    };

    /* 設定モーダルコントロールおよび内部機能 */
    const settingsModal = document.getElementById('settings-modal');
    document.getElementById('open-settings-btn').onclick = openSettingsModal;
    document.getElementById('close-settings-btn').onclick = closeSettingsModal;

    function openSettingsModal() {
        settingsModal.style.display = 'flex';
        buildSettingsHistoryList();
        document.querySelectorAll('.icon-option').forEach(opt => {
            if(opt.getAttribute('data-icon') === myIcon) opt.classList.add('selected');
            else opt.classList.remove('selected');
        });
    }
    function closeSettingsModal() {
        settingsModal.style.display = 'none';
    }

    // ★機能追加: カスタム画像（ドロップ＆クリック）をアイコンに設定する処理
    const customIconDropzone = document.getElementById('custom-icon-dropzone');
    const customIconInput = document.createElement('input');
    customIconInput.type = 'file';
    customIconInput.accept = 'image/*';
    
    customIconDropzone.onclick = () => customIconInput.click();
    customIconDropzone.ondragover = (e) => { e.preventDefault(); customIconDropzone.style.borderColor = currentThemeColor; };
    customIconDropzone.ondragleave = (e) => { customIconDropzone.style.borderColor = '#3f4147'; };
    customIconDropzone.ondrop = (e) => {
        e.preventDefault();
        customIconDropzone.style.borderColor = '#3f4147';
        if(e.dataTransfer.files.length) handleCustomIconFile(e.dataTransfer.files[0]);
    };
    customIconInput.onchange = (e) => {
        if(e.target.files.length) handleCustomIconFile(e.target.files[0]);
    };

    function handleCustomIconFile(file) {
        if (file.size > 2 * 1024 * 1024) { showToast("アイコン画像は2MB以下にしてください"); return; }
        const reader = new FileReader();
        reader.onload = (e) => {
            const img = new Image();
            img.onload = () => {
                const canvas = document.createElement('canvas');
                canvas.width = 64; canvas.height = 64;
                const ctx = canvas.getContext('2d');
                // 丸く切り抜くための処理
                ctx.beginPath();
                ctx.arc(32, 32, 32, 0, Math.PI * 2);
                ctx.clip();
                // 縦横比を維持して中央を切り抜く
                const size = Math.min(img.width, img.height);
                const x = (img.width - size) / 2;
                const y = (img.height - size) / 2;
                ctx.drawImage(img, x, y, size, size, 0, 0, 64, 64);
                
                const base64 = canvas.toDataURL('image/jpeg', 0.8);
                myIcon = `<img src="${base64}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;">`;
                localStorage.setItem('my_permanent_icon', myIcon);
                document.getElementById('my-avatar-display').innerHTML = myIcon;
                
                document.querySelectorAll('.icon-option').forEach(o => o.classList.remove('selected'));
                broadcastUserInfo();
                updateVideoGridUI();
                showToast("カスタムアイコンを設定しました");
            };
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }

    // 設定内の外見絵文字アイコン選択
    document.querySelectorAll('.icon-option').forEach(opt => {
        opt.onclick = () => {
            document.querySelectorAll('.icon-option').forEach(o => o.classList.remove('selected'));
            opt.classList.add('selected');
            myIcon = opt.getAttribute('data-icon');
            localStorage.setItem('my_permanent_icon', myIcon);
            document.getElementById('my-avatar-display').innerHTML = myIcon;
            broadcastUserInfo();
            updateVideoGridUI();
        };
    });

    // 設定内のID変更確定
    document.getElementById('settings-id-change-btn').onclick = () => {
        const n = document.getElementById('settings-my-id-input').value.trim();
        if (n && n.length === 4 && !isNaN(n)) {
            localStorage.setItem('my_permanent_chat_id', n);
            showToast("IDを変更しました。再起動します...");
            setTimeout(() => location.reload(), 1000);
        } else {
            showToast("IDは4桁の数字で入力してください");
        }
    };

    // 設定内に移動した履歴一覧と削除処理の生成
    function buildSettingsHistoryList() {
        const box = document.getElementById('settings-history-list-box');
        box.innerHTML = "";
        const f = JSON.parse(localStorage.getItem('friends_'+VER) || "{}");
        
        if(Object.keys(f).length === 0) {
            box.innerHTML = '<div style="color:#949ba4; font-size:12px; padding:5px;">履歴はありません</div>';
            return;
        }

        Object.keys(f).forEach(num => {
            const row = document.createElement('div');
            row.className = 'settings-history-row';
            row.innerHTML = `<span style="display:flex; align-items:center; gap:6px;"><span class="video-card-name-icon">${f[num].icon || "👤"}</span> ${f[num].name || num} (${num})</span><button class="history-del-btn" title="履歴とフレンドを削除">🗑️</button>`;
            row.querySelector('.history-del-btn').onclick = () => {
                if (confirm(`${f[num].name || num} の履歴とフレンド登録を削除しますか？`)) {
                    localStorage.removeItem('log_'+VER+'_'+num);
                    delete f[num];
                    localStorage.setItem('friends_'+VER, JSON.stringify(f));
                    if(activePeer === num) {
                        activePeer = null;
                        document.getElementById('chat-title').textContent = "フレンドを選択してください";
                        document.getElementById('chat-container').innerHTML = "";
                        updateInputStatus();
                    }
                    renderHistory();
                    buildSettingsHistoryList();
                    showToast("削除しました");
                }
            };
            box.appendChild(row);
        });
    }

    // 定期生存監視とラグ軽減のための状態チェック（2秒ごと）
    setInterval(() => {
        Object.keys(connections).forEach(n => {
            const conn = connections[n];
            if (conn && conn.peerConnection && ['failed','closed'].includes(conn.peerConnection.iceConnectionState)) {
                delete connections[n]; renderHistory();
            }
        });
        Object.keys(activeCalls).forEach(id => {
            const call = activeCalls[id];
            if (call && call.peerConnection && ['failed','closed'].includes(call.peerConnection.iceConnectionState)) {
                removeCall(id);
            }
        });
        if (activePeer) updateInputStatus();
        if (peer.disconnected && !peer.destroyed) peer.reconnect();
        if (peer.destroyed) location.reload();
    }, 2000);
</script>
</body>
</html>
