package br.com.nelsonsoares.todolist.errors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;

public class ExceptionHandlerController {
  
  @ExceptionHandler(HttpMessageNotReadableException.class)
  public ResponseEntity<String> handlerHttpMessageNotReadableException(HttpMessageNotReadableException e){
    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMostSpecificCause().getMessage());
  } 
}
