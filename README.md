# Storage-BabyDicionario

Este é um sistema de armazenamento para dicionários do bebê, desenvolvido porque eu simplesmente quis visto que poderia integrar até mesmo com um supabase storage no modo gratuito e iria me atender extremamente bem, mas quis desenvolver do meu jeito por puro conhecimento.

## Funcionalidades principais

- Upload e armazenamento de arquivos
- Armazenamento e recuperação de imagens

4. Configure as variáveis de ambiente no arquivo `.env` na raiz do projeto ou em seu OS.

## Uso

O sistema oferece os seguintes endpoints:

### Usuários

- Criar um usuário com UUID específico:
  ```
  POST /user/{user_uuid}
  ```

### Uploads

- Fazer upload de uma imagem para um perfil de usuário específico:
  ```
  POST /upload/{user_uuid}/{uuid_profile}
  ```

### Servidor de Imagens

- Capturar imagens (GET):
  ```
  /server-image
  ```

## Licença

Este projeto está licenciado sob a MIT License. Veja o arquivo LICENSE para mais detalhes.