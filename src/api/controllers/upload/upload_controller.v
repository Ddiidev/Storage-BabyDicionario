module upload

import veb
import encoding.base64
import api.ws as ws_context
import domain.upload.interfaces as domain_upload
import domain.profile.interfaces as domain_profile

pub struct WSUpload {
	veb.Middleware[ws_context.Context]
pub:
	handler_upload  domain_upload.IUploadService
	handler_profile domain_profile.IProfileService
}

const error_no_file_reported = {
	'message': 'Nehum arquivo informado'
	'status':  'error'
}

@['/:user_uuid/:uuid_profile'; post]
pub fn (ws &WSUpload) upload(mut ctx ws_context.Context, user_uuid string, uuid_profile string) veb.Result {
	// TODO: Implementar upload de arquivos with multipart/form-data
	// files := ctx.files['file'] or {
	// 	ctx.res.set_status(.unprocessable_entity)
	// 	return ctx.json(upload.error_no_file_reported)
	// }

	// file := files[0] or {
	// 	ctx.res.set_status(.unprocessable_entity)
	// 	return ctx.json(upload.error_no_file_reported)
	// }

	image_bin := base64.decode(ctx.req.data)

	file := if image_bin.len > 0 {
		image_bin.bytestr()
	} else {
		return ctx.json(upload.error_no_file_reported)
	}

	ws.handler_upload.upload(user_uuid, uuid_profile, file) or {
		return ctx.server_error(err.msg())
	}

	ctx.res.set_status(.no_content)
	return ctx.text('')
}
