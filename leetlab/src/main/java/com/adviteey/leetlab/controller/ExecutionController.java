package com.adviteey.leetlab.controller;

import com.adviteey.leetlab.service.ExecutionService;
import com.fasterxml.jackson.databind.ser.std.StdKeySerializers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/execution")
public class ExecutionController {

    @Autowired
    private ExecutionService executionService;

    @PostMapping("/run")
    public Map<String,String> run(@RequestBody Map<String,String> programRequest){
        return executionService.execute(programRequest,false);
    }

    @PostMapping("/submit")
    public Map<String,String> submit(@RequestBody Map<String,String> programRequest){
        return executionService.execute(programRequest,true);
    }
}
