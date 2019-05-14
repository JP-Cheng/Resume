
const inputS = document.getElementById("inputString");
const leftNum = document.getElementById("leftNumber");
const allList = document.getElementById("todoItem");

var todoID = 0;
var completed = document.getElementsByClassName("todo-app__item Completed!").length;
var listID = "list0";
leftNum.innerText = allList.childElementCount - completed + " left";

inputS.addEventListener('keypress', event => {
    if ((event.keyCode === 13) && (event.target.value !== "")) {
        // keycode"13" == enter

        event.preventDefault();
        createItems(todoID);

        inputS.value = "";

        completed = document.getElementsByClassName("todo-app__item Completed!").length;
        leftNum.innerText = allList.childElementCount - completed + " left";
    }
});

function createItems(ithItem) {
    // create html label
    const list = document.createElement("li");
    const checkWrap = document.createElement("div");
    const checkBox = document.createElement("input");
    const label = document.createElement("label");
    const rvInput = document.createElement("h3");
    const xDelete = document.createElement("img");

    // set html label
    /*
        <li class="todo-app__item">
            <div class="todo-app__checkbox">
                <input type="checkbox" id=ithItem>
                <label for=ithItem></label>
            </div>
            <h3 class="todo-app__item-detail">testList</h3>
            <img class="todo-app__item-x" src="./img/x.png" 
                onclick="removeItems(this.parentNode)" id=listID />
        </li> 
    */
    list.setAttribute("class", "todo-app__item");
    list.classList.add("notCompleted");
    checkWrap.setAttribute("class", "todo-app__checkbox");
    checkBox.setAttribute("type", "checkbox");
    checkBox.setAttribute("id", ithItem);
    label.setAttribute("for", ithItem);

    rvInput.setAttribute("class", "todo-app__item-detail");
    rvInput.innerText = event.target.value;
    xDelete.setAttribute("class", "todo-app__item-x");
    xDelete.setAttribute("src", "./img/x.png");
    xDelete.setAttribute("id", listID);
    xDelete.setAttribute("onclick", "removeItems(this.parentNode)");
    todoID++;
    listID = "list" + todoID;

    // create html tree
    list.appendChild(checkWrap);
    list.appendChild(rvInput);
    list.appendChild(xDelete);
    checkWrap.appendChild(checkBox);
    checkWrap.appendChild(label);
    allList.appendChild(list);
}

function removeItems(thisNode) {
    allList.removeChild(thisNode);
    completed = document.getElementsByClassName("todo-app__item Completed!").length;
    leftNum.innerText = allList.childElementCount - completed + " left";
}

function todoCompleted() {

    let selected = document.querySelectorAll("input[type='checkbox']:checked");

    for (let i = 0; i < selected.length; i++) {
        let selectLi = selected[i].parentNode.parentNode;
        if (selectLi.className == "todo-app__item Completed!") {
            selectLi.classList.remove("Completed!");
            selectLi.classList.add("notCompleted");
            let selText = selectLi.childNodes;
            selText[1].style.textDecoration = "none";
        }
        else {
            selectLi.classList.remove("notCompleted");
            selectLi.classList.add("Completed!");
            let selText = selectLi.childNodes;
            selText[1].style.textDecoration = "line-through";
        }
        completed = document.getElementsByClassName("todo-app__item Completed!").length;
        leftNum.innerText = allList.childElementCount - completed + " left";
        selected[i].checked = false;
    }
}

function clearCompleteds() {
    let selected = document.getElementsByClassName("todo-app__item Completed!");
    let selectedLength = selected.length;
    // alert(selectedLength);
    completed = document.getElementsByClassName("todo-app__item Completed!").length;

    while (selectedLength !== 0) {
        removeItems(selected[selectedLength - 1]);
        selectedLength--;
    }
    /*
        Note that you cannot do the below loop; 
            since at every run when it remove a node,
            the array.length will be substrated by 1,
            which cause logic errors.

        for(let i=0;i<selected.length;i++){
            removeItems(selected[selectedLength - i]);
        }
    */
}

function activeFilter() {
    let selected = document.getElementsByClassName("todo-app__item Completed!");
    for (let i = 0; i < selected.length; i++)
        selected[i].style.display = "none";
    // note that NOT visibility="hidden", which is not pretty.

    selected = document.getElementsByClassName("todo-app__item notCompleted");
    for (let i = 0; i < selected.length; i++)
        selected[i].style.display = "";
}

function completedFilter() {
    let selected = document.getElementsByClassName("todo-app__item Completed!");
    for (let i = 0; i < selected.length; i++)
        selected[i].style.display = "";
    // note that NOT visibility="hidden", which is not pretty.

    selected = document.getElementsByClassName("todo-app__item notCompleted");
    for (let i = 0; i < selected.length; i++)
        selected[i].style.display = "none";
}

function showAll() {
    let selected = document.getElementsByClassName("todo-app__item");
    for (let i = 0; i < selected.length; i++)
        selected[i].style.display = "";
}
