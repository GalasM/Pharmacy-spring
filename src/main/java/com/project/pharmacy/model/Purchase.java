package com.project.pharmacy.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="purchase")
public class Purchase {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Double amount;
    private String date;

    @ManyToOne(cascade = {CascadeType.MERGE, CascadeType.PERSIST})
    @JoinTable(
            name = "user_purchases",
            joinColumns = { @JoinColumn(name = "purchase_id") },
            inverseJoinColumns = { @JoinColumn(name = "user_id") }
    )
    private User user;

    public Purchase(Double amount, String date) {
        this.amount = amount;
        this.date = date;
    }

    public Purchase() {
    }

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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
