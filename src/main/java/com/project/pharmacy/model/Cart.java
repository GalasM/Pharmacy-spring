package com.project.pharmacy.model;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "cart")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Double amount;

    @OneToMany(mappedBy = "cart", cascade = {CascadeType.PERSIST})
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Set<CartElement> elements;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Set<CartElement> getElements() {
        return elements;
    }

    public void setElements(Set<CartElement> elements) {
        this.elements = elements;
        this.amount = elements.stream().map(CartElement::getAmount).reduce(0.0, Double::sum);
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
