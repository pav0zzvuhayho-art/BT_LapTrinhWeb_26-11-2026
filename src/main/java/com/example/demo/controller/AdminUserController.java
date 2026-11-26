package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;

@Controller
@RequestMapping("/admin/users")
public class AdminUserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String list(@RequestParam(defaultValue = "") String keyword,
                       @RequestParam(defaultValue = "0") int page,
                       @RequestParam(defaultValue = "5") int size,
                       Model model) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());
        Page<User> userPage = keyword.trim().isEmpty()
                ? userRepository.findAll(pageable)
                : userRepository.findByUsernameContainingIgnoreCaseOrFullnameContainingIgnoreCase(
                        keyword.trim(), keyword.trim(), pageable);

        model.addAttribute("userPage", userPage);
        model.addAttribute("keyword", keyword);
        return "admin/user-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("user", new User());
        return "admin/user-form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        User user = userRepository.findById(id).orElse(null);
        if (user == null) {
            return "redirect:/admin/users";
        }
        model.addAttribute("user", user);
        return "admin/user-form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute User user, Model model) {
        if (user.getId() == null) {
            // Thêm mới: kiểm tra trùng username/email
            if (userRepository.existsByUsername(user.getUsername())) {
                model.addAttribute("error", "Username đã tồn tại!");
                model.addAttribute("user", user);
                return "admin/user-form";
            }
            if (user.getEmail() != null && !user.getEmail().isBlank()
                    && userRepository.existsByEmail(user.getEmail())) {
                model.addAttribute("error", "Email đã tồn tại!");
                model.addAttribute("user", user);
                return "admin/user-form";
            }
            userRepository.save(user);
        } else {
            // Cập nhật: nếu bỏ trống password thì giữ nguyên mật khẩu cũ
            User existing = userRepository.findById(user.getId()).orElse(null);
            if (existing != null) {
                existing.setUsername(user.getUsername());
                existing.setFullname(user.getFullname());
                existing.setEmail(user.getEmail());
                existing.setPhone(user.getPhone());
                existing.setRoleid(user.getRoleid());
                existing.setStatus(user.getStatus());
                if (user.getPassword() != null && !user.getPassword().isBlank()) {
                    existing.setPassword(user.getPassword());
                }
                userRepository.save(existing);
            }
        }
        return "redirect:/admin/users";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        userRepository.deleteById(id);
        return "redirect:/admin/users";
    }
}