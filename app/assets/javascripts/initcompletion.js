function initCompletion(input, target) {

  if (target) {
    input.__always_show  = true;
    input.__completionitems = (typeof target == 'string' ? document.getElementById(target) : target);
  } else {
    input.__always_show  = false;
    input.__completionitems = document.createElement("div");
    input.__completionitems.style.display = "none";
    input.__completionitems.style.borderStyle = "solid";
    input.__completionitems.style.borderWidth = "1px";
    input.__completionitems.style.position = "absolute";
    input.__completionitems.style.textAlign = "left";

    document.body.appendChild(input.__completionitems);
  }
  
  input.clearCompletionItems = function () {
    this.__completionitems.innerHTML = "";
    if (!input.__always_show)
      this.__completionitems.style.display = "none";
  }

  input.setCompletionWidth = function(w) {
    input.__completionitems.__width = w;
  }
  
  input.showCompletionItems = function (ary, callback) {

    this.clearCompletionItems();

    var ci = this.__completionitems;

    if (!target) {
      var x = 0; var y = 0;
      for (var o = this; o ; o = o.offsetParent) {
        x += (o.offsetLeft); y += (o.offsetTop);
      } 

      ci.style.width = "500px";
      ci.style.top = y + this.offsetHeight + "px";
      ci.style.left = x + "px";
      ci.style.display = "block";
    }

    function __addItem(n) {
      var div = document.createElement("div");
      div.style.cursor = "pointer";
      div.style.backgroundColor = "white";
      div.style.font='normal 11px Osaka';
      
      div.onmouseover = function() {
        this.style.backgroundColor = "#36c";
        this.style.color = "white";
      }

      div.onmouseout = function() {
        this.style.backgroundColor = "white";
        this.style.color = "black";
      }

      div.onclick = function() { callback(n, this.innerHTML); }
      div.innerHTML = ary[n];
      ci.appendChild(div);
    }

    for (var i = 0; i < ary.length; ++i)  __addItem(i);
  }

  return input;
}
