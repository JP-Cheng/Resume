# Review on Practice02

## 完成度
整體而言外觀效果很棒，個人很喜歡黑色背景跟鏡面映射的效果，從.js file來看，的確是個非常用心的作品。雖然才學JS沒多久，不過從這個.js file看到很多華麗(?)的技能，只能<(_ _)>  
完成度應該是超過100%吧XD

## coding quality
超過100分ㄅ OAQ  
除了在.js file做出很多炫砲的效果外，也稍微修改了.css file的一些東西，不過最有看點的還是.js file吧

## 正確性
應該也是很完美吧QQ

## 值得學習的地方
因為才初學JS，所以覺得整個炫砲的效果都很值得學習(´･ω･`)  
另外，因為我自己寫的.js file才不到50行，所以沒有注意到；在這份文件中把一些函數的<code>return</code>重新命名，像是第51~58行的這些：

    let nextBtn = document.getElementById('next');
    let backBtn = document.getElementById('back');
    let display = document.getElementById('display');
    let displayNext = document.getElementById('display-next');
    let displayPrev = document.getElementById('display-prev');
    let source = document.getElementById('source');
    let repeat = document.getElementById('checkbox-repeat');
    let shuffle = document.getElementById('checkbox-shuffle');

這樣會讓後面的code看起來比較簡潔，感覺不會產生一些莫名其妙的bugs、也比較好debug。

## 建議改進的地方
其實有一些地方看不是很懂，像是.js file裡面，第76、77行的地方

    nextBtn.onclick = changeNext;
    backBtn.onclick = changeBack;

因為只有大概瀏覽過，不確定這邊把兩個變數重新assign到另外兩個變數的原因是什麼，這樣感覺會有點冗。

另外第102、118、127行的地方，使用了<code>++imgNumber</code>，跟其他地方使用+1、-1的風格不太一樣。  
不過這是小問題啦，整體來說都很棒。

此外個人覺得loading的效果看起來有點不smooth，感覺畫面是用跳的，如果可以讓畫面看起來是用滑的，應該會讓使用者體驗比較好一點。


# <code> let "其他心得" = "<(_ _)>" </code>

