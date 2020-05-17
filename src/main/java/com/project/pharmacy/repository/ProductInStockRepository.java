package com.project.pharmacy.repository;

import com.project.pharmacy.model.ProductInStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductInStockRepository extends JpaRepository<ProductInStock, Long> {

    @Query(value = "select * from product_in_stock where product_id=?1",nativeQuery = true)
    ProductInStock findByProductId(Long id);
}
