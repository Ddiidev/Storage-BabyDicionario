module services

import os
import rand
import domain.config.interfaces as config
import infra.image_magick.repository.service as simage_magick

pub struct UploadService {
pub:
	conf config.IConfig
}

fn (serv &UploadService) upload(user_uuid string, uuid_profile string, data string) ! {
	work_dir := serv.conf.get_work_dir() or { return error('Falha interna.') }

	if !os.exists(os.join_path(work_dir, user_uuid)) {
		return error('Usuário não encontrado.')
	}

	if !os.exists(os.join_path(work_dir, user_uuid, uuid_profile)) {
		os.mkdir(os.join_path(work_dir, user_uuid, uuid_profile)) or {
			return error('Erro ao criar pasta do perfil.')
		}

		os.mkdir(os.join_path(work_dir, user_uuid, uuid_profile, 'temp')) or {
			return error('Erro ao criar pasta temporária do perfil')
		}
	}

	name_file_original := rand.uuid_v4()
	path_image_original := os.join_path(work_dir, user_uuid, uuid_profile, 'temp', name_file_original)
	path_image_dest := os.join_path(work_dir, user_uuid, uuid_profile, 'profile.jpg')

	if os.exists(path_image_dest) {
		os.rm(path_image_dest) or { return error('Erro ao remover imagem') }
	}

	if os.exists(path_image_original) {
		os.rm(path_image_original) or { return error('Erro ao remover imagem') }
	}

	os.write_file(path_image_original, data) or { return error('Erro ao salvar imagem') }

	processar_imagem(path_image_original, path_image_dest)!

	os.rm(path_image_original) or {}
}

fn processar_imagem(name_file_original string, name_file_dest string) ! {
	hmagick := simage_magick.get()

	hmagick.convert(
		path_file_orig: name_file_original
		path_file_dest: name_file_dest
	) or { return error('Erro ao processar imagem | ${err.msg()}') }
}
