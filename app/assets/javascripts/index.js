window.addEventListener("load", function() {
  var btn = document.querySelector("input");

  btn.addEventListener("click", function() {
    var p = document.querySelector("p");
    p.innerText = "クリックされた！";
  });
});