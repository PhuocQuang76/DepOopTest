package com.synergisticit.controller;

import com.synergisticit.modal.AddRequest;
import org.springframework.web.bind.annotation.*;

@RestController

@RequestMapping("/api/v1")
public class AddController {


    @PostMapping("/add")
    public int addNumbers(@RequestBody AddRequest request) {
        return request.getA() + request.getB();
    }

//    @GetMapping("/getNumber")
//    public int getNumber(){
//        return 0;
//    }

}
