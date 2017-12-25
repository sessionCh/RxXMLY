
$( document ).ajaxSend(function( event, request, settings )  {
                          callNativeApp('ajaxSend',settings.data);
                       });
$( document ).ajaxSuccess(function( event, xhr, settings )  {
                          data = document.cookie;
                          callNativeApp ('ajaxSuccess',data);
                        });

window.resize(function( event ){
              getDocumentSize();
              });
function getDocumentSize() {
    window.webkit.messageHandlers.sizeNotification.postMessage({width: document.width, height: document.height});
}

function callNativeApp (cmd,data) {
    
    if(cmd == 'ajaxSend'){
        try {
            webkit.messageHandlers.ajaxSend.postMessage(data);
        }
        catch(err) {
            console.log('The native context does not exist yet');
        }
    } else if(cmd == 'ajaxSuccess') {
    
        try {
            webkit.messageHandlers.ajaxSuccess.postMessage(data);
        }
        catch(err) {
            console.log('The native context does not exist yet');
        }
    }
}

