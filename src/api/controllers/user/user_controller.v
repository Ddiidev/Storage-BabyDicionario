module user

import veb
import api.ws as ws_context
import domain.user.interfaces as domain_user

pub struct WSUser {
	veb.Middleware[ws_context.Context]
pub:
	handler_user domain_user.IUserService
}

@['/:user_uuid'; post]
fn (serv &WSUser) create_user(mut ctx ws_context.Context, user_uuid string) veb.Result {
	serv.handler_user.create_user(user_uuid) or {
		return ctx.json({
			'message': 'Falha ao cadastrar o usuário'
			'status':  'error'
		})
	}

	return ctx.json({
		'message': 'Usuário cadastrado'
		'status':  'error'
	})
}
