package com.makan.project.services;

import org.springframework.stereotype.Service;

import com.makan.project.repositories.ServiceRepositories;

@Service
public class ServiceService {
    private final ServiceRepositories serviceRepositories;

    public ServiceService(ServiceRepositories serviceRepositories) {
        this.serviceRepositories = serviceRepositories;
    }
    public void addService(Service service) {

        serviceRepositories.save(service);
    }
    

}
