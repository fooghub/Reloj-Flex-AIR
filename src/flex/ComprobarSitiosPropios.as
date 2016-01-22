package {
/*
Aplicación Reloj ...
Paquete auxiliar para comprobar disponibilidad de sitios Web:
ComprobarSitiosPropios.as (ActionScript)
***
2004 - 2016 Foog.Software
*/
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.*;
	
    public class ComprobarSitiosPropios extends Sprite {
        private var cargador:URLLoader;
		private var eventoEstado:Event = new Event("estadoSitio");
		
		public var estadoHTTP:Number;
			
        public function ComprobarSitiosPropios(urlSitio:String){
			cargador = new URLLoader();
            configurarEscuchas(cargador);
            var peticiones:URLRequest = new URLRequest(urlSitio);
			peticiones.method = URLRequestMethod.HEAD; 
            cargador.load(peticiones);
        }	

        private function configurarEscuchas(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, controladorEstadoHTTP);
			 dispatcher.addEventListener(IOErrorEvent.IO_ERROR, controladorErrorIO);
        }        
		
        private function controladorEstadoHTTP(event:HTTPStatusEvent):Number{
			estadoHTTP = event.status;
			dispatchEvent(eventoEstado);
			return estadoHTTP;					
        }
		private function controladorErrorIO(event:IOErrorEvent):void {
            estadoHTTP = 0;
        }
    }
}
