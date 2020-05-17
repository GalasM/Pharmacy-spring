package com.project.pharmacy.repository;

import com.project.pharmacy.model.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    @Query(value = "SELECT * FROM CART WHERE USER_ID = ?1", nativeQuery = true)
    Cart findUserCart(Long id);
}
