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

const error_process_audio = {
	'message': 'Falha ao processar o áudio'
	'status':  'error'
}

@['/audio/:user_uuid/:uuid_profile/:key_word'; post]
pub fn (ws &WSUpload) upload_audio(mut ctx ws_context.Context, user_uuid string, uuid_profile string, key_word string) veb.Result {
	audio_bin := base64.decode(ctx.req.data)

	file := if audio_bin.len > 0 {
		audio_bin.bytestr()
	} else if ctx.req.data.len > 0 && audio_bin.len == 0 {
		return ctx.json(upload.error_process_audio)
	} else {
		return ctx.json(upload.error_no_file_reported)
	}

	ws.handler_upload.upload_audio(user_uuid, uuid_profile, key_word, file) or {
		return ctx.server_error(err.msg())
	}

	ctx.res.set_status(.no_content)
	return ctx.text('')
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
