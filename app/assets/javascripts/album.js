(function(){

  $(document).on('click', '.photos li img',  function() {
    console.log("on clicked!");
    var src = $(this).attr('src');
    var img = '<img src="' + src +'" class="img-responsive" />';

    var index = $(this).parent('li').index();
    //console.log("INDEX:" + index);
    var html = '';
    html += img;
    html += '<div style="height:25px; clear: both; display: block;">';
    html += '<a class="control next" index="' + (index+1) +'">next &raquo;</a>';
    html += '<a class="control previous" index="'+ (index-1) + '">&laquo; prev</a>';
    html += '</div>';


    $('#photoModal').modal();
    $('#photoModal').on('shown.bs.modal', function(){
      $('#photoModal .modal-body').html(html);
      var total = $('ul.photos li').length;
      if(index == 0){
        $('a.previous').hide();
      }
      if(index + 1 == total){
        $('a.next').hide();
      }
    });

    $('#photoModal').on('hidden.bs.modal',  function(){
      $('#photoModal .modal-body').html('');
    });
  });

$(document).on('click', 'a.control', function(){
  var index = $(this).attr('index');
  console.log("Clicked index: " + index);
  var src = $('ul.photos li:nth-child('+(parseInt(index)+1)+') img').attr('src');
  //console.log("SRC: " + src);
  var nextIndex = parseInt(index) + 1;
  var preIndex = parseInt(index) - 1;
  $('.modal-body img').attr('src', src);
  if($(this).hasClass('previous')){
    $(this).attr('index', (preIndex));
    $('a.next').attr('index', nextIndex);
  }else {
    $(this).attr('index', (nextIndex));
    $('a.previous').attr('index', preIndex);
  }

  var totalImgs = $('ul.photos li').length;
  console.log("Total imgs: " + totalImgs);
  if(totalImgs == (parseInt(index)+1)){
    $('a.next').hide();
  }else{
    $('a.next').show();
  }

  if(parseInt(index) <= 0){
    $('a.previous').hide();
  }else{
    $('a.previous').show();
  }

});

})();
