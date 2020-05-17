package com.project.pharmacy.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="medicament")
public class Medicament {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private Double price;
    private String type;
    @Lob
    private byte[] photo;
    @OneToMany(mappedBy = "medicament")
    private Set<CartElement> cartElement;

    @OneToOne(mappedBy = "medicament", cascade = CascadeType.ALL,
            fetch = FetchType.LAZY, optional = false)
    private ProductInStock stock;

    public Medicament(String name, Double price, byte[] photo) {
        this.name = name;
        this.price = price;
        this.photo = photo;
    }

    public Medicament() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public byte[] getPhoto() {
        return photo;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }

    public ProductInStock getStock() {
        return stock;
    }

    public void setStock(ProductInStock stock) {
        this.stock = stock;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
