module server_audio

import veb
import api.ws as ws_context
import domain.server_audio.interfaces as domain_server

pub struct WSServerAudio {
	veb.Middleware[ws_context.Context]
pub:
	handler_server_audio domain_server.IServerAudio
}

@['/:user_uuid/:uuid_profile/:key_word'; get]
fn (ws &WSServerAudio) get_audio_profile(mut ctx ws_context.Context, user_uuid string, uuid_profile string, key_word string) veb.Result {
	path_file := ws.handler_server_audio.get_audio_profile(user_uuid, uuid_profile, key_word) or {
		ctx.res.set_status(.unprocessable_entity)
		return ctx.json({
			'message': err.msg()
			'status':  'error'
		})
	}

	return ctx.file(path_file)
}
