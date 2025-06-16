package com.makan.project.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class MakanController {
	
	@GetMapping("/makan")
	public String index() {
		return "index.jsp";
	}
	
}
