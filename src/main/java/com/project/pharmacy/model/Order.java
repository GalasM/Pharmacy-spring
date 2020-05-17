package com.project.pharmacy.model;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String date;

    @OneToMany(mappedBy = "order", cascade = {CascadeType.PERSIST})
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Set<OrderElement> elements;

    public Order() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Set<OrderElement> getElements() {
        return elements;
    }

    public void setElements(Set<OrderElement> elements) {
        this.elements = elements;
    }
}
