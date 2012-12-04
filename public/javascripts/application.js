// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
  function addSnippet(element, node){
    element = $(element);
    insertAtCaret(element, "\n# Running snippet '" + node.innerHTML + "'\nrun_snippet(" + node.id + ")\n");
  }


  function hideDiv(divId){
    Effect.BlindUp(divId, {duration: 0.2});
    return false;
  }
  function showDiv(divId){
    if($(divId).style.display == 'none'){
      Effect.BlindDown(divId, {duration: 0.2});
    }
    return false;
  }
  function toggleDiv(divId){
    if($(divId).style.display == 'none'){
      showDiv(divId);
    } else {
      hideDiv(divId);
    }
  }

  function clear_if_match(element, value, new_value){
    if(element.value==value){
        if(new_value != undefined){
            element.value = new_value;
        }else{
          element.value = "";
        }
    }
  }

  function insertAtCaret(obj, text) {
    if(document.selection) {
      obj.focus();
      var orig = obj.value.replace(/\r\n/g, "\n");
      var range = document.selection.createRange();
      if(range.parentElement() != obj) {
        return false;
      }
        range.text = text;
        var actual = tmp = obj.value.replace(/\r\n/g, "\n");
        for(var diff = 0; diff < orig.length; diff++) {
          if(orig.charAt(diff) != actual.charAt(diff)) break;
        }
        for(var index = 0, start = 0;
          tmp.match(text)
                && (tmp = tmp.replace(text, ""))
                && index <= diff;
          index = start + text.length
          )
          {
            start = actual.indexOf(text, index);
          }
        } else if(obj.selectionStart>=0) {
          var start = obj.selectionStart;
          var end   = obj.selectionEnd;
          obj.value = obj.value.substr(0, start)
                      + text
                      + obj.value.substr(end, obj.value.length);
        }
        if(start != null) {
          setCaretTo(obj, start + text.length);
        } else {
          obj.value += text;
        }
  }

  function setCaretTo(obj, pos) {
    if(obj.createTextRange) {
      var range = obj.createTextRange();
      range.move('character', pos);
      range.select();
    } else if(obj.selectionStart) {
      obj.focus();
      obj.setSelectionRange(pos, pos);
    }
  }

  function toggleCheckBox(id)
  {
    chkBox = $(id);
    chkBox.checked = !chkBox.checked;
  }
  function toggleSelf(obj)
  {
    alert(obj.parent);
    obj.checked = !obj.checked;
  }
