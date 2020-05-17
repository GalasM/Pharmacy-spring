package com.project.pharmacy.repository;

import com.project.pharmacy.model.Medicament;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MedicamentRepository extends JpaRepository<Medicament, Long> {

    @Query(value = "select m.id,m.name,m.photo,m.type,m.price from medicament m inner join product_in_stock pis on pis.product_id=m.id where pis.quantity>0", nativeQuery = true)
    List<Medicament> findAllInStock();
}
