package com.treeptik.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@EqualsAndHashCode
@Entity
@Getter
@Setter
@ToString
public class User {

	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
	@NonNull
	@NotBlank(message = "First name is mandatory")
	private String firstName;
	@NonNull
	@NotBlank(message = "Last name is mandatory")
	private String lastName;
	@NonNull
	@NotBlank(message = "Email is mandatory")
    private String email;
	
	public User(@NonNull String firstName, @NonNull String lastName,
			@NonNull @NotBlank(message = "Email is mandatory") String email) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
	}


}
