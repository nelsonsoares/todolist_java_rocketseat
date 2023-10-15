package br.com.nelsonsoares.todolist.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import at.favre.lib.crypto.bcrypt.BCrypt;

@RestController // Informa que o meu controller é do tipo API Rest
@RequestMapping("/users") // Cria a minha rota
public class UserController {

  @Autowired
  private IUserRepository userRepository;

  @PostMapping("/") // Informa o tipo de método a ser usado
  public ResponseEntity create(@RequestBody UserModel userModel){

   var user = this.userRepository.findByUsername(userModel.getUsername());

   if(user != null){
    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Usuário já Existe!");
   }

   var passwordHashed = BCrypt.withDefaults().hashToString(12, userModel.getPassword().toCharArray());

   userModel.setPassword(passwordHashed);

    var userCreated = userRepository.save(userModel);
    return ResponseEntity.status(HttpStatus.OK).body(userCreated);
  }
}
