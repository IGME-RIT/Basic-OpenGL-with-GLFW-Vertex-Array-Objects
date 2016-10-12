/*
Title: Instanced Rendering
File Name: fragment.glsl
Copyright ? 2016
Author: David Erbelding
Written under the supervision of David I. Schwartz, Ph.D., and
supported by a professional development seed grant from the B. Thomas
Golisano College of Computing & Information Sciences
(https://www.rit.edu/gccis) at the Rochester Institute of Technology.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


#version 400 core

in vec3 position;
in vec2 uv;
in mat3 tbn;

uniform sampler2D diffuseMap;
uniform sampler2D normalMap;

void main(void)
{
	vec4 ambientLight = vec4(.1, .1, .2, 1);
	vec3 pointLightPosition = vec3(1000, 500, 100);
	vec4 pointLightColor = vec4(1, 1, 1, 1);
	vec3 pointLightAttenuation = vec3(1, 1, 0);
	float pointLightRange = 2000;

	// calculate normal from normal map
	vec3 texnorm = normalize(vec3(texture(normalMap, uv)) * 2.0 - 1.0);
	vec3 norm = tbn * texnorm;

	
	// Calculate diffuse lighting
	vec3 lightDir = pointLightPosition - position;
	float distance = length(lightDir) / pointLightRange;
	float attenuation = 1 / (distance * distance * pointLightAttenuation.x + distance * pointLightAttenuation.y + pointLightAttenuation.z);
	float diffuseLight = clamp(dot(normalize(lightDir), normalize(norm)), 0, 1);
	vec4 finalDiffuseColor = clamp(pointLightColor * (diffuseLight) + ambientLight, 0, 1);


	// finally, sample from the texuture and apply the light.
	vec4 color = texture(diffuseMap, uv);
	gl_FragColor = (color * finalDiffuseColor);
}