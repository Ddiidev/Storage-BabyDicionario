module main

import veb
import api.ws
import api.controllers.upload
import api.controllers.server_image
import domain.upload.services as domain_service_upload
import domain.config.services as domain_service_config
import domain.server_image.services as domain_service_server_image

pub struct Wservice {
	veb.Controller
}

fn main() {
	mut wservice := &Wservice{}
	conf_cors := veb.cors[ws.Context](veb.CorsOptions{
		origins:         ['*']
		allowed_methods: [.get, .head, .options, .patch, .put, .post, .delete]
	})

	conf := domain_service_config.ConfigService{}
	mut upload_controller := upload.WSUpload{
		handler_upload: &domain_service_upload.UploadService{
			conf: &conf
		}
	}
	upload_controller.use(conf_cors)

	mut server_image_controller := server_image.WSServerImage{
		handler_server_image: &domain_service_server_image.ServerImageService{
			conf: &conf
		}
	}
	server_image_controller.use(conf_cors)

	wservice.register_controller[upload.WSUpload, ws.Context]('/upload', mut upload_controller)!
	wservice.register_controller[server_image.WSServerImage, ws.Context]('/server-image', mut
		server_image_controller)!

	veb.run[Wservice, ws.Context](mut wservice, 3095)
}
