package com.project.pharmacy.contact;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;


@RestController
public class RegistrationController {

    private Logger logger = LoggerFactory.getLogger(RegistrationController.class);

    @Autowired
    private NotificationService notificationService;

    @PostMapping("/sendMail")
    public RedirectView sendMailSuccess(HttpServletRequest request, RedirectAttributes redirectAttributes){

        String email = request.getParameter("email");
        String temat = request.getParameter("topic");
        String tresc = request.getParameter("content");

        // create user
        Mail mail = new Mail();
        mail.setEmail(email);
        mail.setTopic(temat);
        mail.setContent(tresc);

        // send a notification
        try {
            notificationService.sendNotificaitoin(mail);
        }catch( Exception e ){
            // catch error
            logger.info("Error Sending Email: " + e.getMessage());
        }
        redirectAttributes.addFlashAttribute("mail", "true");

        return new RedirectView("contact");
    }

}