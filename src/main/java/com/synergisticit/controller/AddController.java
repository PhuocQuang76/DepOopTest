package com.synergisticit.controller;

import com.synergisticit.modal.AddRequest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController

@RequestMapping("/api/v1")
public class AddController {


    @PostMapping("/add")
    public int addNumbers(@RequestBody AddRequest request) {
        return request.getA() + request.getB();
    }

}
