module main

import veb
import api.ws
import api.controllers.user
import api.controllers.upload
import api.controllers.server_image
import domain.user.services as domain_service_user
import domain.upload.services as domain_service_upload
import domain.config.services as domain_service_config
import domain.profile.services as domain_service_profile
import domain.server_image.services as domain_service_server_image
import domain.backend_babydi.services as domain_service_backend_babydi

pub struct Wservice {
	veb.Controller
}

fn main() {
	mut wservice := &Wservice{}

	conf_cors := veb.cors[ws.Context](veb.CorsOptions{
		origins:         ['*']
		max_age: 10
		allowed_methods: [.get, .post, .options, .patch, .put, .delete]
	})
	// backend_babydi := domain_service_backend_babydi.BackendBabyDiService{}

	// conf := domain_service_config.ConfigService{}
	mut upload_controller := upload.WSUpload{
		handler_upload: &domain_service_upload.UploadService{
			conf: domain_service_config.ConfigService{}
			api:  domain_service_backend_babydi.BackendBabyDiService{}
		}
		handler_profile: &domain_service_profile.ProfileService{
			api: domain_service_backend_babydi.BackendBabyDiService{}
		}
	}
	upload_controller.use(conf_cors)

	mut server_image_controller := server_image.WSServerImage{
		handler_server_image: &domain_service_server_image.ServerImageService{
			conf: domain_service_config.ConfigService{}
		}
	}
	server_image_controller.use(conf_cors)

	mut user_controller := user.WSUser{
		handler_user: &domain_service_user.UserService{
			conf: domain_service_config.ConfigService{}
			api:  domain_service_backend_babydi.BackendBabyDiService{}
		}
	}
	user_controller.use(conf_cors)

		
	/**
	 * Middlewares para compressão de dados
	 */
	user_controller.use(veb.encode_gzip[ws.Context]())
	upload_controller.use(veb.encode_gzip[ws.Context]())
	server_image_controller.use(veb.encode_gzip[ws.Context]())

	wservice.register_controller[upload.WSUpload, ws.Context]('/upload', mut upload_controller)!
	wservice.register_controller[server_image.WSServerImage, ws.Context]('/server-image', mut
		server_image_controller)!
	wservice.register_controller[user.WSUser, ws.Context]('/user', mut user_controller)!

	veb.run_at[Wservice, ws.Context](mut wservice, port: 3095, timeout_in_seconds: 6000, family: .ip)!
}