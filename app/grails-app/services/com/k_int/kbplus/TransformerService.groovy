package com.k_int.kbplus

//For Transform
import groovyx.net.http.*
import org.apache.http.entity.mime.MultipartEntity
import org.apache.http.entity.mime.content.InputStreamBody
import org.apache.http.entity.mime.content.StringBody
import static groovyx.net.http.ContentType.*
import static groovyx.net.http.Method.*

class TransformerService {

    def triggerTransform(user, filename, tr_id, content, main_response) {
		def transform = hasTransformId(user, tr_id)
		if( transform ){
			
			def tr = transform[0].transforms
			def format = tr.accepts_format.value
			def reqMIME = 'text/xml'
			if(format == 'json')
				reqMIME = 'application/json'
			
			
			main_response.setHeader("Content-disposition", "attachment; filename=${filename}.${tr.return_file_extention}")
			main_response.contentType = tr.return_mime //"text/plain"
			def out = main_response.outputStream
			
			log.debug("Calling transformer: ${tr.transformer.url}")
			
			URL url = new URL(tr.transformer.url);
			def server = "${url.getProtocol()}://${url.getAuthority()}"
			def path = "${url.getPath()}"
			
			def http = new HTTPBuilder(server)
			def msg = ""
			
			http.request( POST ) { request ->
				uri.path = path
				
				MultipartEntity mpe = new MultipartEntity();
				mpe.addPart('path', new StringBody(tr.path_to_stylesheet))
				mpe.addPart(format, new InputStreamBody(new ByteArrayInputStream(content.getBytes()), reqMIME, 'file'))
				request.entity = mpe
				
				response.'401' = { resp ->
					log.error('access denied')
				}
				
				response.success = { resp, reader ->
					assert resp.statusLine.statusCode == 200
					msg += "\nresponse status: ${resp.statusLine}\n"
					msg += "Headers:\n"
					resp.headers.each {
						msg += "${it.name} : ${it.value}\n"
					}
					log.debug(msg)
					out << reader
				}
				
				response.failure = { resp ->
					msg += "\nresponse failed: ${resp.statusLine}\n"
					msg += "Headers:\n"
					resp.headers.each {
						msg += "${it.name} : ${it.value}\n"
					}
					log.error(msg)
					out << msg
				}
			}
			out.close()
		}
		else{
			out << "Looks like you dont't have access to that transform"
		}
    }
	
	
	//check user has access to the transform
	def hasTransformId(user, tr_id){
		def transform = UserTransforms.findAllByUser(user).findAll{ it.transforms.id == Long.valueOf(tr_id) }
		if(transform.size() == 1){
			transform
		}else{
			null
		}
	}
}
