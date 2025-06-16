package com.makan.project.services;

import org.springframework.stereotype.Service;

import com.makan.project.models.Servicee;
import com.makan.project.repositories.ServiceeRepository;

@Service
public class ServiceeService {
    private final ServiceeRepository serviceRepositories;

    public ServiceeService(ServiceeRepository serviceRepositories) {
        this.serviceRepositories = serviceRepositories;
    }
    public void addService(Servicee service) {

        serviceRepositories.save(service);
    }
    

}
