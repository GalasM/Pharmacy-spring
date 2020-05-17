package com.project.pharmacy.service;

import com.project.pharmacy.model.Role;
import com.project.pharmacy.model.User;
import com.project.pharmacy.repository.RoleRepository;
import com.project.pharmacy.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


import java.util.HashSet;

@Service
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Override
    public void save(User user) {

        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        HashSet<Role> roles = new HashSet<>();
        if(user.getRoles()==null){
        roles.add(roleRepository.findByName("ROLE_USER"));
        user.setRoles(roles);
        }
        userRepository.save(user);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
}
