module upload

import veb
import api.ws as ws_context
import domain.upload.interfaces as domain_upload

pub struct WSUpload {
	veb.Middleware[ws_context.Context]
pub:
	handler_upload domain_upload.IUploadService
}

@['/:user_uuid/:uuid_profile'; post]
pub fn (ws &WSUpload) upload(mut ctx ws_context.Context, user_uuid string, uuid_profile string) veb.Result {
	files := ctx.files['file'] or { return ctx.ok('Nenhum arquivo informado') }

	file := files[0] or { return ctx.ok('error') }

	ws.handler_upload.upload(user_uuid, uuid_profile, file.data) or { return ctx.ok(err.msg()) }

	return ctx.ok('ok')
}
