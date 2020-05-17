package com.project.pharmacy.repository;

import com.project.pharmacy.model.CartElement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CartElementRepository extends JpaRepository<CartElement, Long> {

    @Query(value = "select * from cart_element ce where ce.medicament_id=?1 and ce.cart_id=?2",nativeQuery = true)
    CartElement getElementFromCart(Long medicament_id,Long user_id);

    @Modifying
    @Query(value = "delete from cart_element where id=:id", nativeQuery = true)
    void deleteCartElementById(@Param("id") Long id);
}
