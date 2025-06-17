package com.makan.project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.makan.project.models.Servicee;
import com.makan.project.repositories.ServiceeRepository;

@Service
public class ServiceeService {
	@Autowired
	ServiceeRepository serviceeRepository;


    public void addService(Servicee service) {

    	serviceeRepository.save(service);
    }
    

}
