package net.koreate.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 브라우저 /images/** 요청 → C:/web_uploads/ 매핑
        registry.addResourceHandler("/images/**")
                .addResourceLocations("file:///C:/Users/KTE/Desktop/SmartLibrary/cover");
    }
}
