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
	// veb.Middleware[ws.Context]
	veb.Controller
}

fn main() {
	mut wservice := &Wservice{}

	conf_cors := veb.cors[ws.Context](veb.CorsOptions{
		origins:         ['*']
		allowed_methods: [.get, .head, .options, .patch, .put, .post, .delete]
	})
	backend_babydi := domain_service_backend_babydi.BackendBabyDiService{}

	conf := domain_service_config.ConfigService{}
	mut upload_controller := upload.WSUpload{
		handler_upload: &domain_service_upload.UploadService{
			conf: &conf
			api:  &backend_babydi
		}
		handler_profile: &domain_service_profile.ProfileService{
			api: &backend_babydi
		}
	}
	upload_controller.use(conf_cors)

	mut server_image_controller := server_image.WSServerImage{
		handler_server_image: &domain_service_server_image.ServerImageService{
			conf: &conf
		}
	}
	server_image_controller.use(conf_cors)

	mut user_controller := user.WSUser{
		handler_user: &domain_service_user.UserService{
			conf: &conf
			api:  &backend_babydi
		}
	}
	user_controller.use(conf_cors)

	// wservice.use(veb.encode_gzip[ws.Context]())
	// wservice.use(conf_cors)
	wservice.register_controller[upload.WSUpload, ws.Context]('/upload', mut upload_controller)!
	wservice.register_controller[server_image.WSServerImage, ws.Context]('/server-image', mut
		server_image_controller)!
	wservice.register_controller[user.WSUser, ws.Context]('/user', mut user_controller)!

	veb.run[Wservice, ws.Context](mut wservice, 3095)
}