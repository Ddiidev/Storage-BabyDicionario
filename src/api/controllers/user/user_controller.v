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
	serv.handler_user.create(user_uuid) or {
		ctx.res.set_status(.bad_request)
		return ctx.json({
			'message': 'Falha ao cadastrar o usuário.'
			'status':  'error'
		})
	}

	return ctx.json({
		'message': 'Usuário cadastrado'
		'status':  'info'
	})
}

@['/:user_uuid/:profile_uuid'; delete]
fn (serv &WSUser) get_user_profile(mut ctx ws_context.Context, user_uuid string, profile_uuid string) veb.Result {
	serv.handler_user.delete(user_uuid, profile_uuid) or {
		ctx.res.set_status(.bad_request)
		return ctx.json({
			'message': 'Falha ao deletar o perfil do usuário.'
			'status':  'error'
		})
	}

	return ctx.json({
		'message': 'Perfil do usuário deletado'
		'status':  'info'
	})
}
