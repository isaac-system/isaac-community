/**
 *  alert, confirm 대용 팝업 메소드 정의 <br/>
 *  timer : 애니메이션 동작 속도 <br/>
 *  alert : 경고창 <br/>
 *  confirm : 확인창 <br/>
 *  open : 팝업 열기 <br/>
 *  close : 팝업 닫기 <br/>
 */ 
var uiAlert = {
    timer : 500,
    confirm : function(txt, callback){
        if(txt == null || txt.trim() == ""){
            console.warn("confirm message is empty.");
            return;
        }else if(callback == null || typeof callback != 'function'){
            console.warn("callback is null or not function.");
            return;
        }else{
            $(".type-confirm .btn_ok").on("click", function(){
                $(this).unbind("click");
                callback(true);
                action_popup.close(this);
            });
            this.open("type-confirm", txt);
        }
    },

    alert : function(txt){
        if(txt == null || txt.trim() == ""){
            console.warn("confirm message is empty.");
            return;
        }else{
            this.open("type-alert", txt);
        }
    },

    open : function(type, txt){
        var popup = $("."+type);
        popup.find(".menu_msg").text(txt);
        "<div class='dimLayer'></div>"
        $("layoutAuthentication").append();
        $(".dimLayer").css('height', $(document).height()).attr("target", type);
        popup.fadeIn(this.timer);
    },

    close : function(target){
        var modal = $(target).closest(".modal-section");
        var dimLayer;
        if(modal.hasClass("type-confirm")){
            dimLayer = $(".dimLayer[target=type-confirm]");
            $(".type-confirm .btn_ok").unbind("click");
        }else if(modal.hasClass("type-alert")){
            dimLayer = $(".dimLayer[target=type-alert]")
        }else{
            console.warn("close unknown target.")
            return;
        }
        modal.fadeOut(this.timer);
        setTimeout(function(){
            dimLayer != null ? dimLayer.remove() : "";
        }, this.timer);
    }
}