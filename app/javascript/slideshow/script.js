'use strict';
document.addEventListener('turbolinks:load', function() {
  const mypageBtnContainer = document.getElementById('dropdown'); //定数mypageBtnContainerにid:mypageBtnContainerの要素を代入する
  const mypageDropdown = document.getElementById('dropdown-menu');

  if (mypageBtnContainer && mypageDropdown) {
    mypageBtnContainer.addEventListener('mouseenter', function() {
      mypageDropdown.style.display = 'block';
    });

    mypageBtnContainer.addEventListener('mouseleave', function() {
      mypageDropdown.style.display = 'none'; // メニューを非表示にする
    });
  }
});
