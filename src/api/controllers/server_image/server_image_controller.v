module server_image

import veb
import api.ws as ws_context
import domain.server_image.interfaces as domain_server

pub struct WSServerImage {
	veb.Middleware[ws_context.Context]
pub:
	handler_server_image domain_server.IServerImage
}

@['/:user_uuid/:uuid_profile'; get]
fn (ws &WSServerImage) get_image_profile(mut ctx ws_context.Context, user_uuid string, uuid_profile string) veb.Result {
	path_file := ws.handler_server_image.get_image_profile(user_uuid, uuid_profile) or {
		return ctx.ok(err.msg())
	}

	return ctx.file(path_file)
}
