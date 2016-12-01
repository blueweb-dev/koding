package j_invitation

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"time"

	"golang.org/x/net/context"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime"
	cr "github.com/go-openapi/runtime/client"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// NewPostRemoteAPIJInvitationSendInvitationByCodeParams creates a new PostRemoteAPIJInvitationSendInvitationByCodeParams object
// with the default values initialized.
func NewPostRemoteAPIJInvitationSendInvitationByCodeParams() *PostRemoteAPIJInvitationSendInvitationByCodeParams {
	var ()
	return &PostRemoteAPIJInvitationSendInvitationByCodeParams{

		timeout: cr.DefaultTimeout,
	}
}

// NewPostRemoteAPIJInvitationSendInvitationByCodeParamsWithTimeout creates a new PostRemoteAPIJInvitationSendInvitationByCodeParams object
// with the default values initialized, and the ability to set a timeout on a request
func NewPostRemoteAPIJInvitationSendInvitationByCodeParamsWithTimeout(timeout time.Duration) *PostRemoteAPIJInvitationSendInvitationByCodeParams {
	var ()
	return &PostRemoteAPIJInvitationSendInvitationByCodeParams{

		timeout: timeout,
	}
}

// NewPostRemoteAPIJInvitationSendInvitationByCodeParamsWithContext creates a new PostRemoteAPIJInvitationSendInvitationByCodeParams object
// with the default values initialized, and the ability to set a context for a request
func NewPostRemoteAPIJInvitationSendInvitationByCodeParamsWithContext(ctx context.Context) *PostRemoteAPIJInvitationSendInvitationByCodeParams {
	var ()
	return &PostRemoteAPIJInvitationSendInvitationByCodeParams{

		Context: ctx,
	}
}

/*PostRemoteAPIJInvitationSendInvitationByCodeParams contains all the parameters to send to the API endpoint
for the post remote API j invitation send invitation by code operation typically these are written to a http.Request
*/
type PostRemoteAPIJInvitationSendInvitationByCodeParams struct {

	/*Body
	  body of the request

	*/
	Body *models.DefaultSelector

	timeout time.Duration
	Context context.Context
}

// WithTimeout adds the timeout to the post remote API j invitation send invitation by code params
func (o *PostRemoteAPIJInvitationSendInvitationByCodeParams) WithTimeout(timeout time.Duration) *PostRemoteAPIJInvitationSendInvitationByCodeParams {
	o.SetTimeout(timeout)
	return o
}

// SetTimeout adds the timeout to the post remote API j invitation send invitation by code params
func (o *PostRemoteAPIJInvitationSendInvitationByCodeParams) SetTimeout(timeout time.Duration) {
	o.timeout = timeout
}

// WithContext adds the context to the post remote API j invitation send invitation by code params
func (o *PostRemoteAPIJInvitationSendInvitationByCodeParams) WithContext(ctx context.Context) *PostRemoteAPIJInvitationSendInvitationByCodeParams {
	o.SetContext(ctx)
	return o
}

// SetContext adds the context to the post remote API j invitation send invitation by code params
func (o *PostRemoteAPIJInvitationSendInvitationByCodeParams) SetContext(ctx context.Context) {
	o.Context = ctx
}

// WithBody adds the body to the post remote API j invitation send invitation by code params
func (o *PostRemoteAPIJInvitationSendInvitationByCodeParams) WithBody(body *models.DefaultSelector) *PostRemoteAPIJInvitationSendInvitationByCodeParams {
	o.SetBody(body)
	return o
}

// SetBody adds the body to the post remote API j invitation send invitation by code params
func (o *PostRemoteAPIJInvitationSendInvitationByCodeParams) SetBody(body *models.DefaultSelector) {
	o.Body = body
}

// WriteToRequest writes these params to a swagger request
func (o *PostRemoteAPIJInvitationSendInvitationByCodeParams) WriteToRequest(r runtime.ClientRequest, reg strfmt.Registry) error {

	r.SetTimeout(o.timeout)
	var res []error

	if o.Body == nil {
		o.Body = new(models.DefaultSelector)
	}

	if err := r.SetBodyParam(o.Body); err != nil {
		return err
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}