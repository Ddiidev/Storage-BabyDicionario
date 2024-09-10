module services

import os
import rand
import domain.config.interfaces as config
import domain.backend_babydi.interfaces as backend
import infra.image_magick.repository.service as simage_magick

pub struct UploadService {
pub:
	conf config.IConfig
	api  backend.IBackendBabyDi
}

fn (serv &UploadService) upload(user_uuid string, uuid_profile string, data string) ! {
	// if serv.api.contain_profile(uuid_profile) {
		work_dir := serv.conf.get_work_dir() or { return error('Falha interna.') }
		path_user := os.join_path(work_dir, user_uuid)
		path_user_profile := os.join_path(path_user, uuid_profile)
		path_image_dest := os.join_path(path_user_profile, 'profile.jpg')
		path_user_profile_temp := os.join_path(path_user_profile, 'temp')

		if !os.exists(path_user) {
			return error('Usuário não encontrado.')
		}

		if !os.exists(path_user_profile) {
			os.mkdir(path_user_profile) or { return error('Erro ao criar pasta do perfil.') }

			os.mkdir(path_user_profile_temp) or {
				return error('Erro ao criar pasta temporária do perfil')
			}
		}

		name_file_original := rand.uuid_v4()
		path_image_original := os.join_path(path_user_profile_temp, name_file_original)
		if os.exists(path_image_dest) {
			os.rm(path_image_dest) or { return error('Erro ao remover imagem') }
		}

		if os.exists(path_image_original) {
			os.rm(path_image_original) or { return error('Erro ao remover imagem') }
		}

		os.write_file(path_image_original, data) or { return error('Erro ao salvar imagem') }

		processar_imagem(path_image_original, path_image_dest)!

		os.rm(path_image_original) or {}
	// } else {
	// 	return error('Perfil não encontrada.')
	// }
}

fn processar_imagem(name_file_original string, name_file_dest string) ! {
	hmagick := simage_magick.get()

	hmagick.convert(
		path_file_orig: name_file_original
		path_file_dest: name_file_dest
	) or { return error('Erro ao processar imagem | ${err.msg()}') }
}
