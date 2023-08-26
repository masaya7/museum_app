'use strict';
document.addEventListener('turbolinks:load', function() {
  const mypageBtnContainer = document.getElementById('mypageBtnContainer'); //定数mypageBtnContainerにid:mypageBtnContainerの要素を代入する
  const mypageDropdown = document.getElementById('mypageDropdown');

  if (mypageBtnContainer && mypageDropdown) {
    mypageBtnContainer.addEventListener('mouseenter', function() {//それぞれの用語定数・関数・イベントリスナー。。。を理解する
      mypageDropdown.style.display = 'block';
    });

    mypageBtnContainer.addEventListener('mouseleave', function() {
      mypageDropdown.style.display = 'none'; // メニューを非表示にする
    });
  }
});
