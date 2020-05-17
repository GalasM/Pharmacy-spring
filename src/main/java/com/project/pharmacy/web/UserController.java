package com.project.pharmacy.web;

import com.project.pharmacy.model.*;
import com.project.pharmacy.repository.*;
import com.project.pharmacy.service.SecurityService;
import com.project.pharmacy.service.UserService;
import com.project.pharmacy.validator.UserValidator;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.Collectors;


@Controller
public class UserController {
    private final UserService userService;
    private final UserRepository userRepository;
    private final SecurityService securityService;
    private final UserValidator userValidator;
    private final MedicamentRepository medicamentRepository;
    private final CartElementRepository cartElementRepository;
    private final CartRepository cartRepository;
    private final PurchaseRepository purchaseRepository;
    private final ProductInStockRepository productInStockRepository;
    private final OrderElementRepository orderElementRepository;
    private final OrderRepository orderRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public UserController(UserService userService, UserRepository userRepository, SecurityService securityService, UserValidator userValidator,
                          MedicamentRepository medicamentRepository, CartElementRepository cartElementRepository,
                          CartRepository cartRepository, PurchaseRepository purchaseRepository,
                          ProductInStockRepository productInStockRepository, OrderElementRepository orderElementRepository,
                          OrderRepository orderRepository ,BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.userService = userService;
        this.userRepository = userRepository;
        this.securityService = securityService;
        this.userValidator = userValidator;
        this.medicamentRepository = medicamentRepository;
        this.cartElementRepository = cartElementRepository;
        this.cartRepository = cartRepository;
        this.purchaseRepository = purchaseRepository;
        this.productInStockRepository = productInStockRepository;
        this.orderElementRepository = orderElementRepository;
        this.orderRepository = orderRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @PostMapping("/registration")
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "index";
        }
        userService.save(userForm);
        securityService.autoLogin(userForm.getUsername(), userForm.getPasswordConfirm());
        return "redirect:/index";
    }


    @GetMapping("/login")
    public String login(Model model) {
        model.addAttribute("login","login");
        return "index";
    }


    @GetMapping({"/","/index"})
    public String index() {
        return "index";
    }

    @GetMapping({"/offer","/offer/{filter}"})
    public String offer(@PathVariable Optional<String> filter, Model model){
        List<Medicament> products = medicamentRepository.findAllInStock();
        if(filter.isPresent()){
            switch (filter.get()){
                case "przeciwbolowe":
                    products.removeIf(e -> !e.getType().equals("Przeciwbólowy"));
                    break;
                case "urazy":
                    products.removeIf(e -> !e.getType().equals("Urazy"));
                    break;
                case "problemy trawienne":
                    products.removeIf(e -> !e.getType().equals("Problemy trawienne"));
                    break;
                case "przeziebienie":
                    products.removeIf(e -> !e.getType().equals("Przeziębienie"));
                    break;
                case "priceMin":
                    products.sort(Comparator.comparing(Medicament::getPrice));
                    break;
                case "priceMax":
                    products.sort(Comparator.comparing(Medicament::getPrice).reversed());
                    break;
                case "name":
                    products.sort(Comparator.comparing(Medicament::getName));
                    break;
            }
        }
        model.addAttribute("products",products);
        return "offer";
    }

    @GetMapping("/contact")
    public String contact(Model model){
        return "contact";
    }

    @GetMapping("/adminprofile")
    public String adminProfile(Model model){

        return "admin";
    }

    @GetMapping("/products")
    public String products(Model model){
        List<ProductInStock> products = productInStockRepository.findAll();
        Collections.sort(products, Comparator.comparing(ProductInStock::getQuantity));
        model.addAttribute("products",products);
        return "products";
    }

    @GetMapping("/productform")
    public ModelAndView productForm(Model model){
        ModelAndView mav = new ModelAndView("productForm");
        Medicament m = new Medicament();
        mav.addObject("product", m);
        return mav;
    }

    @GetMapping({"/orderform/{id}","/orderform"})
    public String orderForm(@PathVariable Optional<Long> id, Model model){
        List<Medicament> e = medicamentRepository.findAllInStock();
        if(id.isPresent()){
            model.addAttribute("id",id.get());
        }
        model.addAttribute("products",e);
        return "orderForm";
    }
    @Transactional
    @PostMapping("/addproduct")
    public String addProduct(@RequestParam("photo") MultipartFile photo, HttpServletRequest request) throws IOException {
        Medicament m = new Medicament();
        if(!request.getParameter("id").equals("")){
           m = medicamentRepository.findById(Long.parseLong(request.getParameter("id"))).orElseThrow();
           if(!photo.isEmpty())
               m.setPhoto(photo.getBytes());
        }
        else {
            ProductInStock pis = new ProductInStock();
            m.setPhoto(photo.getBytes());
            pis.setQuantity(1L);
            pis.setMedicament(m);
            productInStockRepository.save(pis);
        }
        m.setName(StringUtils.capitalize(request.getParameter("name")));
        m.setPrice(Double.parseDouble(request.getParameter("price")));
        m.setType(request.getParameter("type"));
        medicamentRepository.save(m);

        return "admin";
    }

    @PostMapping("/editproduct/{id}")
    public ModelAndView editProduct(@PathVariable Long id)  {
        ModelAndView mav = new ModelAndView("productForm");
        Medicament m = medicamentRepository.findById(id).orElseThrow();
        mav.addObject("product", m);
        return mav;
    }

    @PostMapping("/addtocart/{id}")
    public String addToCart(@PathVariable Long id, HttpServletRequest request, RedirectAttributes redirectAttributes)  {
        User user = userService.findByUsername(request.getUserPrincipal().getName());
        Cart cart = new Cart();
        Set<CartElement> ce = new HashSet<>();
        if(cartRepository.findUserCart(user.getId())!=null){
          Cart c = cartRepository.findUserCart(user.getId());
          cart = c;
          ce = user.getCart().getElements();
        }
        else {
            cart.setUser(user);
        }
        Medicament m = medicamentRepository.findById(id).orElseThrow();
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        cartRepository.save(cart);
        CartElement element = new CartElement(quantity,m);
        CartElement is = cartElementRepository.getElementFromCart(m.getId(),cart.getId());
        if(is!=null){
            int newQuantity = is.getQuantity()+quantity;
            double newAmout = m.getPrice()*newQuantity;
            is.setAmount(newAmout);
            is.setQuantity(newQuantity);
            cartElementRepository.save(is);
            ce.add(is);

        }else {

            element.setCart(cart);
            cartElementRepository.save(element);
            ce.add(element);
        }

        cart.setElements(ce);
        cartRepository.save(cart);
        redirectAttributes.addFlashAttribute("addproduct", "true");
        return "redirect:/offer";
    }

    @GetMapping("/cart")
    public String cart(HttpServletRequest request, Model model){
        String name = request.getUserPrincipal().getName();
        Cart c =cartRepository.findUserCart(userService.findByUsername(name).getId());

            if(c!=null) {
                Set<CartElement> elements = c.getElements();
                List<CartElement> elementsSorted = elements.stream().collect(Collectors.toList());
                Collections.sort(elementsSorted, Comparator.comparing(o -> o.getMedicament().getName()));
                model.addAttribute("elements", elementsSorted);
                model.addAttribute("sum", c.getAmount());
            }

        return "cart";
    }

    @GetMapping("/buy")
    public String buy(HttpServletRequest request,Model model, RedirectAttributes redirectAttributes) {
        AtomicBoolean error = new AtomicBoolean(false);
        String name = request.getUserPrincipal().getName();
        User user = userService.findByUsername(name);
        Cart userCart = cartRepository.findUserCart(user.getId());


        userCart.getElements().forEach(e -> {
            ProductInStock product = productInStockRepository.findByProductId(e.getMedicament().getId());
            if(product.getQuantity()>=e.getQuantity()){
            long quantity = product.getQuantity();
            quantity = quantity - e.getQuantity();
            product.setQuantity(quantity);
            productInStockRepository.save(product);
            }
            else {
                error.set(true);
            }
        });

        if(error.get()){
            redirectAttributes.addFlashAttribute("stockerror", "true");
            return "redirect:/cart";
        }
        else {
            Purchase userPurchase = new Purchase(userCart.getAmount(),new Date().toString());
            userPurchase.setUser(user);
            purchaseRepository.save(userPurchase);
            return "redirect:/deletecart/" + userCart.getId();
        }
    }

    @GetMapping("/deletecart/{cartId}")
    public String deleteCart(@PathVariable Long cartId, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        cartRepository.deleteById(cartId);
        redirectAttributes.addFlashAttribute("purchase","true");
        return "redirect:/cart";
    }

    @Transactional
    @GetMapping("/deleteproduct/{productId}")
    public String deleteElement(@PathVariable Long productId, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String name = request.getUserPrincipal().getName();
        User u = userService.findByUsername(name);
        Cart c = u.getCart();
        CartElement ce = cartElementRepository.findById(productId).orElseThrow();
        c.setAmount(c.getAmount()-ce.getAmount());
        cartRepository.save(c);
        cartElementRepository.deleteCartElementById(productId);
        redirectAttributes.addFlashAttribute("deleteproduct","true");
        return "redirect:/cart";
    }

    @GetMapping("/editelement/{productId}/{quantity}")
    public String editElement(@PathVariable Long productId,@PathVariable Integer quantity,HttpServletRequest request){
        CartElement ce = cartElementRepository.findById(productId).orElseThrow();
        ce.setQuantity(quantity);
        cartElementRepository.save(ce);
        String name = request.getUserPrincipal().getName();
        User u = userService.findByUsername(name);
        Cart c = u.getCart();
        c.setElements(c.getElements());
        cartRepository.save(c);
        return "redirect:/cart";
    }

    @GetMapping("/deleteFromStock/{id}")
    public String deleteFormStock(@PathVariable Long id,RedirectAttributes redirectAttributes){
        Medicament m = medicamentRepository.findById(id).orElseThrow();
        if(m.getStock().getQuantity()>0){
            redirectAttributes.addFlashAttribute("productinstock", "true");
        }
        else {
            medicamentRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("deleteproduct", "true");
        }
        return "redirect:/products";
    }

    @PostMapping("createorder")
    public String createOreder( HttpServletRequest request, RedirectAttributes redirectAttributes){
        Order o = new Order();
        o.setDate(new Date().toString());
        orderRepository.save(o);
        Medicament m = medicamentRepository.findById(Long.parseLong(request.getParameter("product"))).orElseThrow();
        OrderElement oe = new OrderElement();
        oe.setMedicament(m);
        oe.setOrder(o);
        oe.setQuantity(Long.parseLong(request.getParameter("quantity")));
        Set<OrderElement> orderElements = new HashSet<>();
        orderElements.add(oe);
        orderElementRepository.save(oe);
        o.setElements(orderElements);
        orderRepository.save(o);

        ProductInStock pis = productInStockRepository.findByProductId(Long.parseLong(request.getParameter("product")));
        pis.setQuantity(pis.getQuantity()+Long.parseLong(request.getParameter("quantity")));
        productInStockRepository.save(pis);
        redirectAttributes.addFlashAttribute("order","true");
        return "redirect:/products";
    }

    @GetMapping("/profile")
    public String profile(HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) {
        String name = request.getUserPrincipal().getName();
        User u = userService.findByUsername(name);

        List<Purchase> purchases = purchaseRepository.findUserPurchase(u.getId());
        model.addAttribute("purchases", purchases);

        return "profile";
    }

    @PostMapping("/changepassword")
    public String changePassword(RedirectAttributes redirectAttributes, HttpServletRequest request) {
        User u = userRepository.findByUsername(request.getParameter("username"));
        String newPass = request.getParameter("newPassword");
        String confPass = request.getParameter("passwordConfirm");
        String oldPass = request.getParameter("oldPassword");

        if(newPass.equals(confPass) && bCryptPasswordEncoder.matches(oldPass,u.getPassword())) {
            u.setPassword(newPass);
            userService.save(u);
            redirectAttributes.addFlashAttribute("changed", "true");
        }
        else {
            redirectAttributes.addFlashAttribute("notchanged", "true");
        }
        return "redirect:/profile";
    }

    @GetMapping("/deletebyname/{name}")
    public String deleteUserByName(@PathVariable String name, RedirectAttributes redirectAttributes) {
        User u = userRepository.findByUsername(name);
        userRepository.deleteById(u.getId());
        redirectAttributes.addFlashAttribute("success", "true");
        return "redirect:/logout";
    }

    @GetMapping("/users")
    public String users(Model model) {
        List<User> users = userRepository.findUsers();
        model.addAttribute("users",users);
        return "users";
    }

    @GetMapping({"/deleteUser", "/deleteUser/{id}"})
    public String deleteUser(@PathVariable Optional<Long> id, RedirectAttributes redirectAttributes) {
        if (id.isPresent()) {
            User u = userRepository.findById(id.get()).orElseThrow();
            userRepository.deleteById(id.get());
            redirectAttributes.addFlashAttribute("success", "true");
        }
        return "redirect:/users";
    }



}
