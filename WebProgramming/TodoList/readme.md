# TODO List
 
### 功能說明
---
直觀的輸入然後按Enter就對了！  

左下角會顯示還有幾個任務沒有做。  
中間按鈕的部分，左邊三個（All/Active/Completed）是status filter；右邊的Toggle是切換狀態（Completed! <---> notCompleted），必須先點選每個任務前面的圈圈才可以切換，不然完全不會動。  
右邊的clear是一鍵刪除，把所有Completed的項目都刪掉，不需要先選取。  

如果是要刪除個別項目，直接把游標移動到任務的最右邊，按下X的符號就可以了。  

最後必須注意不能新增超過四個項目（還沒有做出螢幕捲動的功能），不然會按不到下面的按鈕。希望之後可以做出來啦。不過如果是使用safari，任務的部分就可以捲動；但chrome還不行，之後再想辦法解決吧ˊˋ

###  程式說明
---

1. css：這個部分只有做一些小變動（例如按鈕的地方），其他都是用預設值。
2. html：就是把樣子做出來而已。
3. js：  
在Listener的部分，只有輸入任務的時候才使用addListener，其他的（刪除任務、下面五個按鈕）都是使用 <code>onclick=(...)</code> 的做法，寫在html的標籤裡面。  
函數部分，一開始的 <code>input.addListener(...)</code> 是偵測有沒有輸入任務，
<code>createItems(...)</code>與<code>removeItems(...)</code>分別是在新增與刪除任務。此外的五個函數，分別是在實現寫按鈕中的功能。

### 心得
---
這次學到了很多js的功能，單純是想要寫在這邊，當成程式筆記。  

1. node本身是個object，必須要記住這一點，因此可以當作變數傳進函數裡。  
2. 如果想要選取特定的node，必須先確認能不能被<code>getElement()</code>，否則只是白工一場。像是設定只有name的話，就只能使用<code>getElementByName()</code>，不能使用<code>node.nodeName</code>（which return tag name instead of "name" attribute），因此除非可以確定是哪個entry，否則最好不要使用。
3. 在使用任合的函數或功能之前，最好能夠在console先試試看，不然<code>alert(...)</code>也是個不錯的方法，不要寫了一堆卻只能得到<code>undefine</code>或是任何因為某個變數值是 <code>undefine</code> 的錯誤。
