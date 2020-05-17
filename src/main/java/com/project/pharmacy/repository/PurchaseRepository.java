package com.project.pharmacy.repository;

import com.project.pharmacy.model.Purchase;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PurchaseRepository extends JpaRepository<Purchase, Long> {
    @Query(value = "SELECT * FROM purchase p inner join user_purchases up on p.id=up.purchase_id  where up.user_id = ?1", nativeQuery = true)
    List<Purchase> findUserPurchase(Long id);
}
