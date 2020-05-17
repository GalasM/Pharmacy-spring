package com.project.pharmacy.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="cart_element")
public class CartElement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Integer quantity;
    private Double amount;
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "medicament_id", referencedColumnName = "id")
    private Medicament medicament;

    @ManyToOne
    @JoinColumn(name="cart_id", nullable=false)
    private Cart cart;

    public CartElement(Integer quantity, Medicament medicament) {
        this.quantity = quantity;
        this.medicament = medicament;
        this.amount = medicament.getPrice()*quantity;
    }

    public CartElement() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
        this.amount = medicament.getPrice()*quantity;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Medicament getMedicament() {
        return medicament;
    }

    public void setMedicament(Medicament medicament) {
        this.medicament = medicament;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }
}
