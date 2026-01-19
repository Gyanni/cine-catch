package com.project.cinecatch.domain.member.dto;

import com.project.cinecatch.domain.member.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberResponse {
    private Long id;
    private String email;
    private String nickname;
    private String role;

    public static MemberResponse from(Member member) {
        return MemberResponse.builder()
                .id(member.getId())
                .email(member.getEmail())
                .nickname(member.getNickname())
                .role(member.getRole())
                .build();
    }
}

@Getter
@AllArgsConstructor
@Builder
public class TokenResponse {
    private String grantType;     // 보통 "Bearer"라고 보냄
    private String accessToken;   // 실제 권한을 주는 토큰
    private Long accessTokenExpiresIn; // 만료 시간
}